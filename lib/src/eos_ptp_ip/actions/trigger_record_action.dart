import '../communication/ptp_transaction_queue.dart';
import '../constants/properties/movie_recording_status.dart';
import '../constants/ptp_property.dart';
import '../extensions/to_byte_extensions.dart';
import 'action.dart';

class TriggerRecordAction extends Action<void> {
  final bool shouldRecord;

  TriggerRecordAction(this.shouldRecord);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    final desiredRecordStatus = shouldRecord
        ? MovieRecordingStatus.recording
        : MovieRecordingStatus.notRecording;

    final setRecordStatus = operationFactory.createSetPropValue(
      PtpPropertyCode.movieRecordingStatus,
      desiredRecordStatus.native.asUint32Bytes(),
    );

    final response = await transactionQueue.handle(setRecordStatus);
    verifyOperationResponse(
        response, 'triggerRecordAction($desiredRecordStatus)');
  }
}
