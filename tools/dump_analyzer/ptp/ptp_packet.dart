import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

sealed class PtpPacket {
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
