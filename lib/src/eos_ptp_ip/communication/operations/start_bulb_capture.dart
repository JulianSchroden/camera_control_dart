import '../../constants/ptp_operation_code.dart';
import 'ptp_operation.dart';

class StartBulbCapture extends PtpRequestOperation {
  const StartBulbCapture() : super(PtpOperationCode.startBulbCapture);
}
