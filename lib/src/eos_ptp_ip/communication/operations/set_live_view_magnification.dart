import '../../../common/models/properties/live_view_magnification.dart';
import '../../adapter/ptp_packet_builder.dart';
import '../../constants/ptp_operation_code.dart';
import 'ptp_operation.dart';

extension LiveViewMagnificationNativeValueExtension on LiveViewMagnification {
  int get native => switch (this) {
        LiveViewMagnification.x1 => 0x01,
        LiveViewMagnification.x5 => 0x5,
        LiveViewMagnification.x10 => 0x0a,
      };
}

class SetLiveViewMagnification extends PtpRequestOperation {
  final LiveViewMagnification liveViewMagnification;

  const SetLiveViewMagnification(this.liveViewMagnification)
      : super(PtpOperationCode.setLiveViewMagnification);

  @override
  void preparePayload(PtpPacketBuilder builder) {
    builder.addUInt32(liveViewMagnification.native);
  }
}
