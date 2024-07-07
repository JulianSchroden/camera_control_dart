import 'dart:io';
import 'dart:mirrors';

import 'package:camera_control_dart/src/eos_ptp_ip/adapter/ptp_event_data_parser.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/events/prop_value_changed.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_operation_code.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

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
    PtpTransaction transaction,
    Map<int, String> knownOperations,
  ) {
    final operationName =
        knownOperations[transaction.operationCode] ?? 'Unknown';
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

void main() async {
  // final file = File('test/_test_data/Connect_Set_Aputure_To_f5.pcapng');
  final file =
      File('test/_test_data/Change_Photo_Video_Selector_on_Camera_2.pcapng');
  // final file = File('test/_test_data/Enable_MovieMode_on_Camera.pcapng');
  final output = FileOutputWriter(fileName: 'tools/output.txt');
  final List<int> ignoredOperationCodes = [
    //PtpOperationCode.getLiveViewImage,
  ];

  final fileData = await file.readAsBytes();
  final blocks = parsePcapngBlocks(fileData);

  final rawPtpIpPackets = blocks
      .whereType<EnhancedPacketBlock>()
      .map((packetBlock) => packetBlock.mapPacket())
      .where((packet) => isPtpIpPacket(packet))
      .toList();

  final mappedPacketFrames = mapPtpPackets(rawPtpIpPackets);
  final transactions = mapPtpTransactions(mappedPacketFrames)
      .where((transaction) =>
          !ignoredOperationCodes.contains(transaction.operationCode))
      .toList();

  final knownOperations = getKnownOperationCodes();
  for (final transaction in transactions) {
    output.write(transaction.formatToString(transaction, knownOperations));
  }

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
