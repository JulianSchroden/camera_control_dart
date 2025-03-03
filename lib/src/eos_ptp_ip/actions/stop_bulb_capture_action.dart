import '../communication/ptp_transaction_queue.dart';
import '../constants/capture_phase.dart';
import 'action.dart';

class StopBulbCaptureAction extends Action<void> {
  StopBulbCaptureAction([super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    final stopBulbRelease =
        operationFactory.createStopImageCapture(CapturePhase.release);
    final stopReleaseResponse = await transactionQueue.handle(stopBulbRelease);
    verifyOperationResponse(stopReleaseResponse, 'stopBulbRelease');

    final stopBulbFocus =
        operationFactory.createStopImageCapture(CapturePhase.focus);
    final stopFocusResponse = await transactionQueue.handle(stopBulbFocus);
    verifyOperationResponse(stopFocusResponse, 'stopBulbFocus');
  }
}
