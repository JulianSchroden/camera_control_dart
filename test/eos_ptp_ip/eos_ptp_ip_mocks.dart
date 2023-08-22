import 'package:camera_control_dart/src/eos_ptp_ip/communication/operations/ptp_operation_factory.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/ptp_transaction_queue.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/responses/ptp_response.dart';
import 'package:mocktail/mocktail.dart';

class MockPtpOperationFactory extends Mock implements PtpOperationFactory {}

class MockPtpTransactionQueue extends Mock implements PtpTransactionQueue {}

class FakePtpResponse extends Fake implements PtpResponse {}
