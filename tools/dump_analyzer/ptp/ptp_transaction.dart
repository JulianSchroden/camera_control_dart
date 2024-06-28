import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

class PtpTransaction {
  final int transactionId;
  final int operationCode;
  final Uint8List requestPayload;
  final int responseCode;
  final Uint8List dataPayload;

  PtpTransaction({
    required this.transactionId,
    required this.operationCode,
    required this.requestPayload,
    required this.responseCode,
    required this.dataPayload,
  });

  @override
  String toString() {
    return '''
Transaction(
  id: $transactionId,
  operationCode: ${operationCode.asHex()},
  requestPayload: ${requestPayload.dumpAsHex(indentationCount: 6)},
  responseCode: ${responseCode.asHex()},
  dataPayload: ${dataPayload.dumpAsHex(indentationCount: 6)})
''';
  }
}
