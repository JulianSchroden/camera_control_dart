import '../../camera_models.dart';
import '../../common/models/camera_connection_handle.dart';
import '../../common/models/camera_model.dart';
import '../communication/ptp_transaction_queue.dart';
import '../constants/capture_destination.dart';
import '../constants/event_mode.dart';
import '../constants/ptp_property.dart';
import '../constants/remote_mode.dart';
import '../extensions/to_byte_extensions.dart';
import 'action.dart';

class InitSessionAction extends Action<void> {
  final CameraConnectionHandle connectionHandle;

  InitSessionAction(this.connectionHandle, [super.operationFactory]);

  @override
  Future<void> run(PtpTransactionQueue transactionQueue) async {
    await _openSession(transactionQueue);

    await _enableRemoteMode(transactionQueue);

    await _enableEventMode(transactionQueue);

    await _setCaptureDestination(transactionQueue, CaptureDestination.storage2);
  }

  Future<void> _openSession(PtpTransactionQueue transactionQueue) async {
    final openSession = operationFactory.createOpenSession(sessionId: 0x41);
    final response = await transactionQueue.handle(openSession);
    verifyOperationResponse(response, 'openSession');
  }

  Future<void> _enableRemoteMode(PtpTransactionQueue transactionQueue) async {
    final remoteMode = _remoteModeByModel(connectionHandle.model);
    final setRemoteMode = operationFactory.createSetRemoteMode(remoteMode);
    final response = await transactionQueue.handle(setRemoteMode);
    verifyOperationResponse(response, 'setRemoteMode');
  }

  Future<void> _enableEventMode(PtpTransactionQueue transactionQueue) async {
    final setEventMode = operationFactory.createSetEventMode(EventMode.enabled);
    final response = await transactionQueue.handle(setEventMode);
    verifyOperationResponse(response, 'setEventMode');
  }

  Future<void> _setCaptureDestination(
    PtpTransactionQueue transactionQueue,
    CaptureDestination captureDestination,
  ) async {
    final setCaptureDestination = operationFactory.createSetPropValue(
      PtpPropertyCode.captureDestination,
      captureDestination.value.asUint32Bytes(),
    );
    final response = await transactionQueue.handle(setCaptureDestination);
    verifyOperationResponse(response, 'setCaptureDestination');
  }

  RemoteMode _remoteModeByModel(CameraModel model) {
    if (model.identifier == CameraModels.canonR7.identifier) {
      return RemoteMode.enabledOnR;
    }

    return RemoteMode.enabled;
  }
}
