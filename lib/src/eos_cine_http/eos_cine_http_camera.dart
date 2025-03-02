import '../common/adapter/polled_data_stream_controller.dart';
import '../common/camera.dart';
import '../common/camera_config.dart';
import '../common/live_view/live_view_data.dart';
import '../common/live_view/polled_live_view_acquisition.dart';
import '../common/models/camera_descriptor.dart';
import '../common/models/camera_update_event.dart';
import '../common/models/camera_update_response.dart';
import '../common/models/capabilities/control_prop_capability.dart';
import '../common/models/capabilities/live_view_capability.dart';
import '../common/models/capabilities/movie_record_capability.dart';
import '../common/models/properties/autofocus_position.dart';
import '../common/models/properties/camera_mode.dart';
import '../common/models/properties/exposure_mode.dart';
import '../common/property_control/control_prop.dart';
import '../common/property_control/control_prop_type.dart';
import '../common/property_control/control_prop_value.dart';
import 'adapter/http_adapter.dart';
import 'communication/action_factory.dart';
import 'models/camera_info.dart';
import 'models/eos_cine_prop_value.dart';

class EosCineHttpCamera extends Camera with PolledLiveViewAcquisition {
  final HttpAdapter httpAdapter;
  final CameraConfig config;
  final ActionFactory actionFactory;

  PolledDataStreamController<CameraUpdateEvent>? _eventController;
  int _nextUpdateSequence = 0;

  EosCineHttpCamera(
    this.httpAdapter,
    this.config, [
    this.actionFactory = const ActionFactory(),
  ]);

  @override
  Future<void> close() async {
    await httpAdapter.close();
  }

  @override
  Future<void> disconnect() async {
    await close();
  }

  @override
  Future<CameraDescriptor> getDescriptor() async {
    return const CameraDescriptor(
      mode: CameraMode.video(ExposureMode.manual),
      capabilities: [
        ControlPropCapability(supportedProps: [
          ControlPropType.aperture,
          ControlPropType.iso,
          ControlPropType.shutterAngle,
          ControlPropType.whiteBalance,
        ]),
        LiveViewCapability(
          aspectRatio: 16 / 9,
          supportsTouchAutofocus: false,
        ),
        MovieRecordCapility(),
      ],
    );
  }

  @override
  Future<ControlProp?> getProp(
    ControlPropType propType,
  ) {
    final getPropAction =
        actionFactory.createGetPropAction(httpAdapter, propType);
    return getPropAction();
  }

  @override
  Future<void> setProp(
    ControlPropType propType,
    ControlPropValue propValue,
  ) async {
    final setPropAction = actionFactory.createSetPropAction(
      httpAdapter,
      propType,
      propValue as EosCinePropValue,
    );
    await setPropAction();
  }

  @override
  Future<void> captureImage() async {}

  @override
  Future<void> triggerRecord() async {
    final triggerRecordAction =
        actionFactory.createTriggerRecordAction(httpAdapter);
    await triggerRecordAction();
  }

  @override
  Future<void> toggleAfLock() async {
    final toggleAfLockAction =
        actionFactory.createToggleAfLockAction(httpAdapter);
    await toggleAfLockAction();
  }

  @override
  Stream<CameraUpdateEvent> events() {
    _eventController ??= PolledDataStreamController<CameraUpdateEvent>(
      pollInterval: config.eventPollingInterval,
      pollData: (sink) async {
        final response = await getUpdate();
        sink.addStream(Stream.fromIterable(response.cameraEvents));
      },
      broadcast: true,
    );

    return _eventController!.stream;
  }

  Future<CameraUpdateResponse> getUpdate() async {
    final getUpdateAction =
        actionFactory.createGetUpdateAction(httpAdapter, _nextUpdateSequence);
    final response = await getUpdateAction();

    _nextUpdateSequence = response.updateSequnce;
    return CameraUpdateResponse(cameraEvents: response.cameraEvents);
  }

  @override
  Future<void> startLiveView() async {
    final startLiveViewAction =
        actionFactory.createStartLiveViewAction(httpAdapter);
    await startLiveViewAction();
  }

  @override
  Future<void> stopLiveView() async {
    final stopLiveViewAction =
        actionFactory.createStopLiveViewAction(httpAdapter);
    await stopLiveViewAction();
  }

  @override
  Future<LiveViewData> getLiveViewData() async {
    final getLiveViewImageAction =
        actionFactory.createGetLiveViewImageAction(httpAdapter);
    return getLiveViewImageAction();
  }

  Future<CameraInfo> getInfo() async {
    final getInfoAction = actionFactory.createGetInfoAction(httpAdapter);
    return getInfoAction();
  }

  @override
  Future<void> setAutofocusPosition(
      AutofocusPosition autofocusPosition) async {}
}
