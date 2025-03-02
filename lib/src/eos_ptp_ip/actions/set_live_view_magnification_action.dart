import '../../common/models/properties/live_view_magnification.dart';
import '../communication/ptp_transaction_queue.dart';
import 'action.dart';

class SetLiveViewMagnificationAction extends Action<void> {
  final LiveViewMagnification liveViewMagnification;

  SetLiveViewMagnificationAction(this.liveViewMagnification,
      [super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    final setLiveViewMagnification =
        operationFactory.createSetLiveViewMagnification(liveViewMagnification);
    final response = await transactionQueue.handle(setLiveViewMagnification);
    verifyOperationResponse(response, 'startBulbCapture');
  }
}
