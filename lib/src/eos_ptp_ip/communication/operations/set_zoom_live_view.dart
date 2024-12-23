import '../../adapter/ptp_packet_builder.dart';
import '../../constants/capture_phase.dart';
import '../../constants/ptp_operation_code.dart';
import '../../constants/zoom_live_view.dart';
import 'ptp_operation.dart';

class SetZoomLiveView extends PtpRequestOperation {
  final ZoomLiveView zoomLiveView;
  const SetZoomLiveView(this.zoomLiveView)
      : super(PtpOperationCode.zoom);

  @override
  void preparePayload(PtpPacketBuilder builder) {
    builder.addUInt32(zoomLiveView.value);//0x05
  }
}
