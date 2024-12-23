import '../../adapter/ptp_packet_builder.dart';
import '../../constants/capture_phase.dart';
import '../../constants/ptp_operation_code.dart';
import 'ptp_operation.dart';

class BulbEnd extends PtpRequestOperation {
  const BulbEnd()
      : super(PtpOperationCode.bulbEnd);

  @override
  void preparePayload(PtpPacketBuilder builder) {

  }
}
