import 'dart:io';
import 'dart:mirrors';

import 'package:args/args.dart';
import 'package:camera_control_dart/src/common/extensions/list_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/adapter/ptp_event_data_parser.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/adapter/ptp_packet_reader.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/events/allowed_values_changed.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/events/prop_value_changed.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_operation_code.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_property.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_property_code.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/models/eos_ptp_int_prop_value.dart';

import '../../test/eos_ptp_ip/adapter/ptp_event_data_parser_test.dart';
import 'data_layers/application/application_layer_frame.dart';
import 'data_layers/map_packet.dart';

import 'data_layers/network/ip4v/ipv4_frame.dart';
import 'data_layers/packet.dart';
import 'data_layers/transport/tcp/tcp_frame.dart';
import 'output/file_output_writer.dart';
import 'pcapng/blocks/enhanced_packet_block.dart';
import 'pcapng/parse_pcapng_blocks.dart';
import 'ptp/map_ptp_packets.dart';
import 'ptp/map_ptp_transaction.dart';
import 'ptp/prop_value_changeset.dart';
import 'ptp/ptp_transaction.dart';

const int ptpIpPort = 15740;

bool isPtpIpPacket(Packet packet) {
  if (packet
      case Packet(
        networkLayerFrame: Ipv4Frame(),
        transportLayerFrame: TcpFrame(
          :final sourcePort,
          :final destinationPort
        ),
        applicationLayerFrame: ApplicationLayerFrame()
      ) when (sourcePort == ptpIpPort || destinationPort == ptpIpPort)) {
    return true;
  }
  return false;
}

Map<int, String> getKnownOperationCodes() {
  final operationCodeMirror = reflectClass(PtpOperationCode);

  return Map.fromEntries(
    operationCodeMirror.staticMembers.keys.map<MapEntry<int, String>>(
      (fieldSymbol) {
        final int operationCode =
            operationCodeMirror.getField(fieldSymbol).reflectee;
        final operationName = MirrorSystem.getName(fieldSymbol);

        return MapEntry(operationCode, operationName);
      },
    ),
  );
}

extension FormatToStringExtension on PtpTransaction {
  String formatToString(
    Map<int, String> knownOperations,
  ) {
    final operationName = knownOperations[operationCode] ?? 'Unknown';
    return '''
Transaction(
  id: $transactionId,
  operationCode: ${operationCode.asHex()} ($operationName),
  frameNumbers: $frameNumbers
  requestPayload: ${requestPayload.dumpAsHex(indentationCount: 4)},
  responseCode: ${responseCode.asHex()},
  dataPayload: ${dataPayload.dumpAsHex(indentationCount: 4)})
''';
  }
}

enum ArgType {
  option,
  flag,
}

enum Argument {
  file(abbr: 'f', type: ArgType.option, mandatory: false),
  transactions(abbr: 't', type: ArgType.option);

  const Argument({
    required this.abbr,
    required this.type,
    this.mandatory = false,
  });
  final String abbr;
  final ArgType type;
  final bool mandatory;
}

enum TransactionAnalysisMode {
  all,
  setProp,
}

extension RegisterArgumentsExtension on ArgParser {
  void registerArguments() {
    addOption(Argument.file.name,
        abbr: Argument.file.abbr, mandatory: Argument.file.mandatory);
    addOption(Argument.transactions.name, abbr: Argument.transactions.abbr);
  }
}

extension ReadArgumentsExtension on ArgResults {
  String? getArgument(Argument argument) {
    return option(argument.name);
  }

  bool getFlag(Argument argument) {
    return flag(argument.name);
  }
}

class AnalyzerOptions {
  final String inputPath;
  final String outputPath;
  final TransactionAnalysisMode? transactionAnalysisMode;
  final List<int> ignoredOperationCodes;
  final int startFrame;

  const AnalyzerOptions({
    required this.inputPath,
    required this.outputPath,
    required this.transactionAnalysisMode,
    this.ignoredOperationCodes = const [],
    this.startFrame = 0,
  });
}

AnalyzerOptions parseArguments(List<String> args) {
  final parser = ArgParser();
  parser.registerArguments();
  final result = parser.parse(args);

  final inputPath = result.getArgument(Argument.file);
  if (inputPath == null) {
    throw ArgumentError(
        'Please provide a path to the pcapng file using the --file argument');
  }

  final outputPath = '${inputPath.split('.')[0]}.txt';
  final transactionAnalysisArg = result.getArgument(Argument.transactions);
  final transactionAnalysisMode = TransactionAnalysisMode.values
      .firstWhereOrNull((type) => type.name == transactionAnalysisArg);

  return AnalyzerOptions(
    inputPath: inputPath,
    outputPath: outputPath,
    transactionAnalysisMode: transactionAnalysisMode,
  );
}

void main(List<String> args) async {
  final options = parseArguments(args);

  final file = File(options.inputPath);
  print('Writing output to file ${options.outputPath}');
  final output = FileOutputWriter(fileName: options.outputPath);

  final fileData = await file.readAsBytes();
  final blocks = parsePcapngBlocks(fileData);

  final rawPtpIpPackets = blocks
      .whereType<EnhancedPacketBlock>()
      .map((packetBlock) => packetBlock.mapPacket())
      .where((packet) =>
          isPtpIpPacket(packet) && packet.frameNumber >= options.startFrame)
      .toList();

  final mappedPacketFrames = mapPtpPackets(rawPtpIpPackets);
  final transactions = mapPtpTransactions(mappedPacketFrames)
      .where((transaction) =>
          !options.ignoredOperationCodes.contains(transaction.operationCode))
      .toList();

  final knownOperations = getKnownOperationCodes();
  final setPropValueTransactions = transactions.where((transaction) =>
      transaction.operationCode == PtpOperationCode.setPropValue);

  switch (options.transactionAnalysisMode) {
    case TransactionAnalysisMode.all:
      {
        output.write('\nAll Transactions');
        for (final transaction in transactions) {
          output.write(transaction.formatToString(knownOperations));
        }
      }
    case TransactionAnalysisMode.setProp:
      {
        output.write('\nSetPropValue Transactions');
        for (final transaction in setPropValueTransactions) {
          output.write(transaction.formatToString(knownOperations));
        }
      }
    default:
      {}
  }

  final getEventTransactions = transactions.where((transaction) =>
      transaction.operationCode == PtpOperationCode.getEventData);

  final events = getEventTransactions.map((transaction) {
    final dataParser = PtpEventDataParser();
    return dataParser.parseEvents(transaction.dataPayload).map((event) => (
          transactionId: transaction.transactionId,
          event: event,
        ));
  }).expand((mappings) => mappings);

  final allowedValuesChangedEventMappings =
      events.where((mapping) => mapping.event is AllowedValuesChanged);

  output.write('\nAllowedValuesChanged events');
  for (final (:transactionId, :event) in allowedValuesChangedEventMappings) {
    output.write('$transactionId: $event');
  }

  final propChangedEventMapping =
      events.where((mapping) => mapping.event is PropValueChanged);

  output.write('\nPropChanged events');
  for (final (:transactionId, :event) in propChangedEventMapping) {
    output.write('$transactionId: $event');
  }

  output.write('\nMovie Format analysis');
  final setMovieFormatValues = setPropValueTransactions
      .map((transaction) {
        final reader = PtpPacketReader.fromBytes(transaction.dataPayload);
        final length = reader.getUint32();
        final propCode = reader.getUint32();

        if (propCode != PtpPropertyCode.movieRecordingFormat) {
          return null;
        }

        return reader.readFallbackValue();
      })
      .whereNotNull()
      .toList();

  Map<int, Set<int>> knownValues = {};
  for (final value in setMovieFormatValues) {
    final reader = PtpPacketReader.fromBytes(value.payload);
    int counter = 0;
    while (reader.unconsumedBytes >= 4) {
      final value = reader.getUint32();
      (knownValues[counter] ??= {}).add(value);

      counter++;
    }
  }

  output.write('knownValues:');
  for (final entry in knownValues.entries) {
    output.write(
        '${entry.key}: ${entry.value.map((value) => '${value.asHex()} ($value)')}');
  }

  return;
  List<PropValueChanged> parsePropChangedEvents(
    List<PtpTransaction> transactions, {
    required int transactionId,
  }) {
    final getEventTransaction = transactions.firstWhere(
        (transaction) => transaction.transactionId == transactionId);
    final parser = PtpEventDataParser();
    return parser
        .parseEvents(getEventTransaction.dataPayload)
        .whereType<PropValueChanged>()
        .toList();
  }

  const transactionIdAfterEnablingMovieMode = 165;
  final propChangedEventsAfterEnablingMovieMode = parsePropChangedEvents(
      transactions,
      transactionId: transactionIdAfterEnablingMovieMode);
  output.write(
      '\nEvents of transaction $transactionIdAfterEnablingMovieMode, count: ${propChangedEventsAfterEnablingMovieMode.length}');
  output.write(propChangedEventsAfterEnablingMovieMode.join('\n'));

  const transactionIdAfterDisablingMovieMode = 182;
  final propChangedEventsAfterDisablingMovieMode = parsePropChangedEvents(
      transactions,
      transactionId: transactionIdAfterDisablingMovieMode);
  output.write(
      '\nEvents of transaction $transactionIdAfterDisablingMovieMode, count: ${propChangedEventsAfterDisablingMovieMode.length}');
  output.write(propChangedEventsAfterDisablingMovieMode.join('\n'));

  final changeSet = mapChangeset(propChangedEventsAfterEnablingMovieMode,
      propChangedEventsAfterDisablingMovieMode);

  output.write('\nChangeset:');
  output.write(changeSet.join('\n'));
}

/*
i: 38

[
   00 00 00 00 32 14 06 00  36 fa 0d 42 8c 00 00 00
   8c 00 00 00 
   Ethernet:
               f8 a2 6d ae  50 68 bc d0 74 02 ac 8e
   08 00
   Internet Protocol:      
         45 02 00 7e 00 00  40 00 40 06 54 c6 c0 a8
   b2 2c c0 a8 b2 34 

   TCP:
                  f4 96  3d 7c 30 df b6 11 e9 cc
   a9 7e 80 18 08 0a c8 fe  00 00 01 01 08 0a 8e de
   2e 6b ff ff 90 4d

   PTP/IP:
                     4a 00  00 00 01 00 00 00 10 aa
   ab 67 bf 70 7c 43 8f 4f  32 b3 df d9 fd 1e 4d 00
   61 00 63 00 42 00 6f 00  6f 00 6b 00 20 00 50 00
   72 00 6f 00 20 00 76 00  6f 00 6e 00 20 00 4a 00
   75 00 6c 00 69 00 61 00  6e 00 00 00 00 00 01 00
]

]
*/

/*


[
   45 00 00 b5 9e 7f 00 00  04 11 b4 e1 c0 a8 b2 34
   ef ff ff fa ed 18 07 6c  00 a1 1d e2 4e 4f 54 49
   46 59 20 2a 20 48 54 54  50 2f 31 2e 31 0d 0a 48
   6f 73 74 3a 20 32 33 39  2e 32 35 35 2e 32 35 35
   2e 32 35 30 3a 31 39 30  30 0d 0a 4e 54 3a 20 75
   70 6e 70 3a 72 6f 6f 74  64 65 76 69 63 65 0d 0a
   4e 54 53 3a 20 73 73 64  70 3a 62 79 65 62 79 65
   0d 0a 55 53 4e 3a 20 75  75 69 64 3a 30 30 30 30
   30 30 30 30 2d 30 30 30  30 2d 30 30 30 30 2d 30
   30 30 31 2d 46 38 41 32  36 44 41 45 35 30 36 38
   3a 3a 75 70 6e 70 3a 72  6f 6f 74 64 65 76 69 63
   65 0d 0a 0d 0a 
]
0x8004500: 0xb59e7f

*/
