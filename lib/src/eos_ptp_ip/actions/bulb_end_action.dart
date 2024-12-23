import '../communication/ptp_transaction_queue.dart';
import '../constants/capture_phase.dart';
import 'action.dart';

class BulbEndAction extends Action<void> {
  BulbEndAction([super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    await _startBulb(transactionQueue);
  }

  Future<void> _startBulb(PtpTransactionQueue transactionQueue) async {
    final startFocus =
        operationFactory.createBulbEnd();
    final response = await transactionQueue.handle(startFocus);
    verifyOperationResponse(response, 'startBulbCapture');
  }
}
