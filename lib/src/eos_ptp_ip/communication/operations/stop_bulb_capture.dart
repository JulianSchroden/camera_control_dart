import '../../constants/ptp_operation_code.dart';
import 'ptp_operation.dart';

class StopBulbCapture extends PtpRequestOperation {
  const StopBulbCapture() : super(PtpOperationCode.stopBulbCapture);
}
