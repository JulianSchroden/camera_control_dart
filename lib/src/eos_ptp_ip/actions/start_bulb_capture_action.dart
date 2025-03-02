import '../communication/ptp_transaction_queue.dart';
import 'action.dart';

class StartBulbCaptureAction extends Action<void> {
  StartBulbCaptureAction([super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    final startBulbCapture = operationFactory.createStartBulbCapture();
    final response = await transactionQueue.handle(startBulbCapture);

    verifyOperationResponse(response, 'startBulbCapture');
  }
}
