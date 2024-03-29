import 'dart:io';
import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_package_type.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

import 'data_layers/application/application_layer_frame.dart';
import 'data_layers/map_packet.dart';

import 'data_layers/network/ip4v/ipv4_frame.dart';
import 'data_layers/packet.dart';
import 'data_layers/transport/tcp/tcp_frame.dart';
import 'pcapng/blocks/enhanced_packet_block.dart';
import 'pcapng/parse_pcapng_blocks.dart';
import 'pcapng/pcapng_reader.dart';

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

class PtpPacket {
  final int length;
  final int packetType;
  final int transactionId;

  const PtpPacket({
    required this.length,
    required this.packetType,
    required this.transactionId,
  });

  @override
  String toString() {
    return 'PtpPacket(length: $length, type: $packetType)';
  }
}

class PtpOperationRequest extends PtpPacket {
  final int operationCode;
  final int dataMode;

  final Uint8List payload;

  const PtpOperationRequest({
    required super.length,
    required super.packetType,
    required super.transactionId,
    required this.operationCode,
    required this.dataMode,
    required this.payload,
  });

  @override
  String toString() {
    return 'PtpOperationRequest(operationCode: ${operationCode.asHex()}, length: $length, dataMode: $dataMode, transactionId: $transactionId, payload: ${payload.dumpAsHex()})';
  }
}

class PtpOperationResponse extends PtpPacket {
  final int operationCode;

  const PtpOperationResponse({
    required super.length,
    required super.packetType,
    required super.transactionId,
    required this.operationCode,
  });

  @override
  String toString() {
    return 'PtpOperationResponse(operationCode: ${operationCode.asHex()}, length: $length, transactionId: $transactionId)';
  }
}

class PtpStartDataPacket extends PtpPacket {
  final int dataLength;

  const PtpStartDataPacket({
    required super.length,
    required super.packetType,
    required super.transactionId,
    required this.dataLength,
  });

  @override
  String toString() {
    return 'PtpStartDataPacket(length: $length, transactionId: $transactionId, dataLength: $dataLength)';
  }
}

class PtpEndDataPacket extends PtpPacket {
  final Uint8List payload;

  const PtpEndDataPacket({
    required super.length,
    required super.packetType,
    required super.transactionId,
    required this.payload,
  });

  @override
  String toString() {
    return 'PtpEndDataPacket(length: $length, transactionId: $transactionId, payload: ${payload.dumpAsHex()})';
  }
}

class PtpMappingResponse {
  final int consumedBytes;
  final PtpPacket? packet;

  PtpMappingResponse({
    required this.consumedBytes,
    this.packet,
  });
}

PtpMappingResponse mapPtpPacket(Uint8List data, int frameNumber) {
  final dataReader = ByteDataReader.fromBytes(data, Endian.little);
  if (dataReader.hasNoValidPtpSegment) {
    return PtpMappingResponse(consumedBytes: 0);
  }

  final segmentReader = dataReader.readPtpSegment();
  final packetLength = segmentReader.getUint32();
  final packetType = segmentReader.getUint32();

  switch (packetType) {
    case PtpPacketType.operationRequest:
      {
        final dataMode = segmentReader.getUint32();
        final operationCode = segmentReader.getUint16();
        final transactionId = segmentReader.getUint32();
        final payload = segmentReader.getRemainingBytes();
        final request = PtpOperationRequest(
          length: packetLength,
          packetType: packetType,
          operationCode: operationCode,
          dataMode: dataMode,
          transactionId: transactionId,
          payload: payload,
        );

        return PtpMappingResponse(
          consumedBytes: dataReader.consumedBytes,
          packet: request,
        );
      }
    case PtpPacketType.operationResponse:
      {
        final operationCode = segmentReader.getUint16();
        final transactionId = segmentReader.getUint32();

        final packet = PtpOperationResponse(
          length: packetLength,
          packetType: packetType,
          operationCode: operationCode,
          transactionId: transactionId,
        );

        return PtpMappingResponse(
          consumedBytes: dataReader.consumedBytes,
          packet: packet,
        );
      }
    case PtpPacketType.startDataPacket:
      {
        final transactionId = segmentReader.getUint32();
        final dataLength = segmentReader.getUint64();

        final dataStartPacket = PtpStartDataPacket(
          length: packetLength,
          packetType: packetType,
          transactionId: transactionId,
          dataLength: dataLength,
        );
        return PtpMappingResponse(
          consumedBytes: dataReader.consumedBytes,
          packet: dataStartPacket,
        );
      }
    case PtpPacketType.endDataPacket:
      {
        final transactionId = segmentReader.getUint32();
        final payload = segmentReader.getRemainingBytes();

        final endDataPacket = PtpEndDataPacket(
          length: packetLength,
          packetType: packetType,
          transactionId: transactionId,
          payload: payload,
        );

        return PtpMappingResponse(
          consumedBytes: dataReader.consumedBytes,
          packet: endDataPacket,
        );
      }
  }

  return PtpMappingResponse(consumedBytes: dataReader.consumedBytes);
}

Map<int, PtpPacket> mapPtpPackets(List<Packet> packets) {
  final bytesBuilder = BytesBuilder();
  final Map<int, PtpPacket> mappedPackets = {};
  for (final packet in packets) {
    if (packet
        case Packet(
          :final frameNumber,
          applicationLayerFrame: ApplicationLayerFrame(:final payload)
        ) when payload.isNotEmpty) {
      bytesBuilder.add(payload);
      final byteBuffer = Uint8List.fromList(bytesBuilder.takeBytes());

      final mappingResult = mapPtpPacket(byteBuffer, frameNumber);
      if (mappingResult case PtpMappingResponse(:final PtpPacket packet)) {
        mappedPackets[frameNumber] = packet;
      }

      if (byteBuffer.length > mappingResult.consumedBytes) {
        final remainingBytes = byteBuffer.sublist(mappingResult.consumedBytes);
        bytesBuilder.add(remainingBytes);
      }
    }
  }

  return mappedPackets;
}

void main() async {
  final file = File('test/_test_data/Connect_Set_Aputure_To_f5.pcapng');

  final fileData = await file.readAsBytes();
  final blocks = parsePcapngBlocks(fileData);

  final rawPtpIpPackets = blocks
      .whereType<EnhancedPacketBlock>()
      .map((packetBlock) => packetBlock.mapPacket())
      .where((packet) => isPtpIpPacket(packet))
      .toList();

  final List<int> ignoredTransactionIds = [];
  final mappedPackets = mapPtpPackets(rawPtpIpPackets);

  mappedPackets.removeWhere((frameNumber, packet) {
    if (packet case PtpOperationRequest(operationCode: 0x9116)) {
      ignoredTransactionIds.add(packet.transactionId);
      return true;
    }

    if (packet case PtpOperationResponse()) {
      return true;
    }

    return ignoredTransactionIds.contains(packet.transactionId);
  });

  for (final MapEntry(key: frameNumber, value: packet)
      in mappedPackets.entries) {
    if (packet is PtpOperationRequest) {
      print('');
    }

    print('$frameNumber: $packet');
  }

  final usedOperationCodes = mappedPackets.values
      .whereType<PtpOperationRequest>()
      .map((request) => request.operationCode)
      .toSet()
      .toList()
    ..sort();

  print('used operation codes:');
  for (final operationCode in usedOperationCodes) {
    print(operationCode.asHex());
  }
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