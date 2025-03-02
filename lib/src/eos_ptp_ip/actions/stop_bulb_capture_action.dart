import '../communication/ptp_transaction_queue.dart';
import 'action.dart';

class StopBulbCaptureAction extends Action<void> {
  StopBulbCaptureAction([super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    final stopBulbCapture = operationFactory.createStopBulbCapture();
    final response = await transactionQueue.handle(stopBulbCapture);

    verifyOperationResponse(response, 'stopBulbCapture');
  }
}
