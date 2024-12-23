import 'dart:async';

import 'package:camera_control_dart/src/common/models/properties/zoom_mode.dart';

import '../common/camera.dart';
import '../common/exceptions/camera_communication_exception.dart';
import '../common/live_view/live_view_data.dart';
import '../common/live_view/polled_live_view_acquisition.dart';
import '../common/models/camera_descriptor.dart';
import '../common/models/camera_update_event.dart';
import '../common/models/properties/autofocus_position.dart';
import '../common/property_control/control_prop.dart';
import '../common/property_control/control_prop_type.dart';
import '../common/property_control/control_prop_value.dart';
import 'actions/action_factory.dart';
import 'adapter/eos_ptp_event_processor.dart';
import 'adapter/ptp_descriptor_mapper.dart';
import 'cache/ptp_property_cache_extensions.dart';
import 'communication/ptp_transaction_queue.dart';
import 'constants/properties/live_view_output.dart';
import 'constants/zoom_live_view.dart';
import 'models/eos_ptp_int_prop_value.dart';

class EosPtpIpCamera extends Camera with PolledLiveViewAcquisition {
  final PtpTransactionQueue _transactionQueue;
  final ActionFactory _actionFactory;
  final EosPtpEventProcessor _eventProcessor;

  EosPtpIpCamera(
    this._transactionQueue,
    this._actionFactory,
    this._eventProcessor,
  );

  @override
  Future<void> close() async {
    await _transactionQueue.close();
  }

  @override
  Future<void> disconnect() async {
    final deinitSession = _actionFactory.createDeinitSessionAction();
    await deinitSession.run(_transactionQueue);
    await close();
  }

  @override
  Future<CameraDescriptor> getDescriptor() async {
    final descriptorMapper = PtpDescriptorMapper(_eventProcessor.propertyCache);
    return descriptorMapper.mapDescriptor();
  }

  @override
  Future<ControlProp?> getProp(ControlPropType propType) async {
    return _eventProcessor.propertyCache.getProp(propType);
  }

  @override
  Future<void> setProp(
    ControlPropType propType,
    ControlPropValue propValue,
  ) async {
    final setPropAction = _actionFactory.createSetPropAction(
      propType,
      propValue as EosPtpIntPropValue,
    );
    await setPropAction.run(_transactionQueue);
  }

  @override
  Stream<CameraUpdateEvent> events() => _eventProcessor.events;

  @override
  Future<void> captureImage() async {
    final captureImage = _actionFactory.createCaptureImageAction();
    await captureImage.run(_transactionQueue);
  }

  @override
  Future<void> triggerRecord() async {
    final isRecording = _eventProcessor.propertyCache.isRecording;
    final triggerRecord =
        _actionFactory.createTriggerRecordAction(!isRecording);
    await triggerRecord.run(_transactionQueue);
  }

  @override
  Future<void> toggleAfLock() async {}

  @override
  Future<void> startLiveView() async {
    final startLiveView = _actionFactory.createSetLiveViewOutputAction(
      _eventProcessor,
      LiveViewOutput.cameraAndHost,
    );
    await startLiveView.run(_transactionQueue);
  }

  @override
  Future<void> stopLiveView() async {
    final stopLiveView = _actionFactory.createSetLiveViewOutputAction(
      _eventProcessor,
      LiveViewOutput.none,
    );
    await stopLiveView.run(_transactionQueue);
  }

  @override
  Future<LiveViewData> getLiveViewData() async {
    final getLiveViewImage = _actionFactory
        .createGetLiveViewImageAction(_eventProcessor.propertyCache);
    return await getLiveViewImage.run(_transactionQueue);
  }

  @override
  Future<void> setAutofocusPosition(AutofocusPosition autofocusPosition) async {
    const focusDuration = Duration(seconds: 1);
    final sensorInfo = _eventProcessor.propertyCache.getSensorInfo();
    if (sensorInfo == null) {
      throw const CameraCommunicationException(
          'Cannot set autofocusPosition since sensorInfo is null');
    }

    final setAutofocusPosition = _actionFactory.createSetTouchAfPositionAction(
      autofocusPosition,
      sensorInfo,
      focusDuration,
    );
    await setAutofocusPosition.run(_transactionQueue);
  }

  @override
  set pollInterval(interval){
    _eventProcessor.pollInterval=interval;
  }
  @override
  Duration get pollInterval{
    return _eventProcessor.pollInterval;
  }

  @override
  Future<void> setZoom(ZoomMode zm) async {
    ZoomLiveView zoomLiveView =
    switch(zm) {
      ZoomMode.x1 =>ZoomLiveView.x1,
      ZoomMode.x5 =>ZoomLiveView.x5,
      ZoomMode.x10=>ZoomLiveView.x10,
      _=>ZoomLiveView.x1,
    };
    final zoom = _actionFactory.createSetZoom(zoomLiveView);
    await zoom.run(_transactionQueue);
  }

  @override
  Future<void> bulbStart() async{
    final bulbStart = _actionFactory.createBulbStart();
    await bulbStart.run(_transactionQueue);
  }

  @override
  Future<void> bulbEnd() async{
    final bulbEnd = _actionFactory.createBulbEnd();
    await bulbEnd.run(_transactionQueue);
  }
}
