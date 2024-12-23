import 'package:camera_control_dart/src/eos_ptp_ip/constants/zoom_live_view.dart';

import '../communication/ptp_transaction_queue.dart';
import '../constants/capture_phase.dart';
import 'action.dart';

class SetZoomLiveViewAction extends Action<void> {

  final ZoomLiveView zoomLiveView;
  SetZoomLiveViewAction(this.zoomLiveView, [super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    await _startZoom(transactionQueue);
  }

  Future<void> _startZoom(PtpTransactionQueue transactionQueue) async {
    final startZoom =
        operationFactory.setZoomLiveView(zoomLiveView);
    final response = await transactionQueue.handle(startZoom);
    verifyOperationResponse(response, 'startBulbCapture');
  }
}
