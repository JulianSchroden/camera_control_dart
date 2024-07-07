import 'dart:typed_data';

class PtpTransaction {
  final int transactionId;
  final int operationCode;
  final Uint8List requestPayload;
  final int responseCode;
  final Uint8List dataPayload;
  final List<int> frameNumbers;

  PtpTransaction({
    required this.transactionId,
    required this.operationCode,
    required this.requestPayload,
    required this.responseCode,
    required this.dataPayload,
    required this.frameNumbers,
  });
}
