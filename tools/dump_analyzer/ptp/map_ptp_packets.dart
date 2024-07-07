import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_package_type.dart';

import '../data_layers/application/application_layer_frame.dart';
import '../data_layers/packet.dart';
import '../pcapng/pcapng_reader.dart';
import 'ptp_packet.dart';

class PtpPacketFrame<P extends PtpPacket> {
  final int frameNumber;
  final P packet;

  const PtpPacketFrame({required this.frameNumber, required this.packet});
}

List<PtpPacketFrame> mapPtpPackets(List<Packet> packets) {
  final bytesBuilder = BytesBuilder();
  final List<PtpPacketFrame> mappedPackets = [];
  for (final packet in packets) {
    if (packet
        case Packet(
          :final frameNumber,
          applicationLayerFrame: ApplicationLayerFrame(:final payload)
        ) when payload.isNotEmpty) {
      bytesBuilder.add(payload);
      final byteBuffer = Uint8List.fromList(bytesBuilder.takeBytes());

      final mappingResult = _mapPtpPacket(byteBuffer, frameNumber);
      if (mappingResult case _PtpMappingResponse(:final PtpPacket packet)) {
        mappedPackets.add(
          PtpPacketFrame(
            frameNumber: frameNumber,
            packet: packet,
          ),
        );
      }

      if (byteBuffer.length > mappingResult.consumedBytes) {
        final remainingBytes = byteBuffer.sublist(mappingResult.consumedBytes);
        bytesBuilder.add(remainingBytes);
      }
    }
  }

  return mappedPackets;
}

class _PtpMappingResponse {
  final int consumedBytes;
  final PtpPacket? packet;

  _PtpMappingResponse({
    required this.consumedBytes,
    this.packet,
  });
}

_PtpMappingResponse _mapPtpPacket(Uint8List data, int frameNumber) {
  final dataReader = ByteDataReader.fromBytes(data, Endian.little);
  if (dataReader.hasNoValidPtpSegment) {
    return _PtpMappingResponse(consumedBytes: 0);
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

        return _PtpMappingResponse(
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

        return _PtpMappingResponse(
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
        return _PtpMappingResponse(
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

        return _PtpMappingResponse(
          consumedBytes: dataReader.consumedBytes,
          packet: endDataPacket,
        );
      }
  }

  return _PtpMappingResponse(consumedBytes: dataReader.consumedBytes);
}
