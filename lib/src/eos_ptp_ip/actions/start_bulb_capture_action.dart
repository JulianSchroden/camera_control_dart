import '../communication/ptp_transaction_queue.dart';
import '../constants/capture_autofocus_mode.dart';
import '../constants/capture_phase.dart';
import 'action.dart';

class StartBulbCaptureAction extends Action<void> {
  StartBulbCaptureAction([super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    final startBulbFocus = operationFactory.createStartImageCapture(
        CapturePhase.focus, CaptureAutofocusMode.noAutofocus);
    final startFocusResponse = await transactionQueue.handle(startBulbFocus);
    verifyOperationResponse(startFocusResponse, 'startBulbFocus');

    final startBulbRelease = operationFactory.createStartImageCapture(
        CapturePhase.release, CaptureAutofocusMode.noAutofocus);
    final startReleaseResponse =
        await transactionQueue.handle(startBulbRelease);
    verifyOperationResponse(startReleaseResponse, 'startBulbRelease');
  }
}
