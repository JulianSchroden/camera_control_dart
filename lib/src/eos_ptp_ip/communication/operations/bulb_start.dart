import '../../adapter/ptp_packet_builder.dart';
import '../../constants/capture_phase.dart';
import '../../constants/ptp_operation_code.dart';
import 'ptp_operation.dart';

class BulbStart extends PtpRequestOperation {

  const BulbStart()
      : super(PtpOperationCode.bulbStart);

  @override
  void preparePayload(PtpPacketBuilder builder) {

  }
}
