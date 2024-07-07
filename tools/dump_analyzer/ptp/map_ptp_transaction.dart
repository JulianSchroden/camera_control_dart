import 'dart:typed_data';

import 'package:camera_control_dart/src/common/extensions/list_extensions.dart';

import 'map_ptp_packets.dart';
import 'ptp_packet.dart';
import 'ptp_transaction.dart';

List<PtpTransaction> mapPtpTransactions(Iterable<PtpPacketFrame> packetFrames) {
  return packetFrames
      .fold(<int, _MutablePtpTransaction>{}, (transactions, packetFrame) {
        final PtpPacketFrame(:frameNumber, :packet) = packetFrame;

        final transaction = transactions[packet.transactionId] ??=
            _MutablePtpTransaction(transactionId: packet.transactionId);

        transaction.frameNumbers.add(frameNumber);

        switch (packet) {
          case PtpOperationRequest(:final operationCode, :final payload):
            {
              transaction.operationCode = operationCode;
              transaction.requestPayload = payload;
            }
          case PtpEndDataPacket(:final payload):
            {
              transaction.dataPayload = payload;
            }
          case PtpOperationResponse(:final operationCode):
            {
              transaction.responseCode = operationCode;
            }
          default:
            {}
        }
        return transactions;
      })
      .values
      .map((mutableTransaction) => mutableTransaction.toTransaction())
      .whereNotNull()
      .toList();
}

class _MutablePtpTransaction {
  int transactionId;
  int? operationCode;
  Uint8List? requestPayload;
  int? responseCode;
  Uint8List? dataPayload;
  List<int> frameNumbers = [];

  _MutablePtpTransaction({required this.transactionId});

  PtpTransaction? toTransaction() {
    if (operationCode == null || responseCode == null) {
      return null;
    }
    return PtpTransaction(
      transactionId: transactionId,
      operationCode: operationCode!,
      requestPayload: requestPayload ?? Uint8List(0),
      responseCode: responseCode!,
      dataPayload:
          dataPayload != null ? Uint8List.fromList(dataPayload!) : Uint8List(0),
      frameNumbers: frameNumbers,
    );
  }
}
