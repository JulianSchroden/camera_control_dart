import 'dart:async';

import '../common/camera.dart';
import '../common/camera_config.dart';
import '../common/live_view/live_view_data.dart';
import '../common/live_view/polled_live_view_acquisition.dart';
import '../common/models/camera_descriptor.dart';
import '../common/models/camera_update_event.dart';
import '../common/models/capabilities/control_prop_capability.dart';
import '../common/models/capabilities/live_view_capability.dart';
import '../common/models/capabilities/movie_record_capability.dart';
import '../common/property_control/control_prop.dart';
import '../common/property_control/control_prop_type.dart';
import '../common/property_control/control_prop_value.dart';
import '../common/models/properties/autofocus_position.dart';
import '../common/models/properties/camera_mode.dart';
import '../common/models/properties/exposure_mode.dart';
import 'data/demo_live_view_image.dart';
import 'models/demo_prop_value.dart';

class DemoCamera extends Camera with PolledLiveViewAcquisition {
  final CameraConfig config;

  DemoCamera(this.config);

  final List<ControlProp> _dummyControlProps = [
    ControlProp(
      type: ControlPropType.iso,
      currentValue: const DemoPropValue('100'),
      allowedValues:
          ['100', '200', '400'].map((value) => DemoPropValue(value)).toList(),
    ),
    ControlProp(
      type: ControlPropType.aperture,
      currentValue: const DemoPropValue('2.8'),
      allowedValues:
          ['2.8', '4.0', '5.6'].map((value) => DemoPropValue(value)).toList(),
    ),
    ControlProp(
      type: ControlPropType.shutterAngle,
      currentValue: const DemoPropValue('180'),
      allowedValues: ['90', '180', '270', '360']
          .map((value) => DemoPropValue(value))
          .toList(),
    ),
    ControlProp(
      type: ControlPropType.whiteBalance,
      currentValue: const DemoPropValue('5600'),
      allowedValues: List.generate(
          50, (index) => DemoPropValue((2000 + index * 100).toString())),
    )
  ];
  bool _reordState = false;
  final _updateStreamController =
      StreamController<CameraUpdateEvent>.broadcast();

  @override
  Future<void> close() async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<CameraDescriptor> getDescriptor() async {
    return CameraDescriptor(
      mode: const CameraMode.photo(ExposureMode.manual),
      capabilities: [
        ControlPropCapability(
          supportedProps: _dummyControlProps.map((prop) => prop.type).toList(),
        ),
        const LiveViewCapability(
          aspectRatio: 16 / 9,
          supportsTouchAutofocus: true,
        ),
        const MovieRecordCapility(),
      ],
    );
  }

  @override
  Future<ControlProp?> getProp(ControlPropType propType) async {
    return _dummyControlProps.firstWhere((prop) => prop.type == propType);
  }

  @override
  Stream<CameraUpdateEvent> events() => _updateStreamController.stream;

  @override
  Future<void> setProp(
      ControlPropType propType, ControlPropValue propValue) async {
    await Future.delayed(config.eventPollingInterval);

    final propIndex =
        _dummyControlProps.indexWhere((prop) => prop.type == propType);
    _dummyControlProps[propIndex] =
        _dummyControlProps[propIndex].copyWith(currentValue: propValue);

    _updateStreamController
        .add(CameraUpdateEvent.propValueChanged(propType, propValue));
  }

  @override
  Future<void> toggleAfLock() async {}

  @override
  Future<void> captureImage() async {}

  @override
  Future<void> startBulbCapture() async {}

  @override
  Future<void> stopBulbCapture() async {}

  @override
  Future<void> triggerRecord() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _reordState = !_reordState;

    _updateStreamController.add(CameraUpdateEvent.recordState(_reordState));
  }

  @override
  Future<void> startLiveView() async {}

  @override
  Future<void> stopLiveView() async {}

  @override
  Future<LiveViewData> getLiveViewData() async {
    return LiveViewData(imageBytes: demoLiveViewImage);
  }

  @override
  Future<void> setAutofocusPosition(
      AutofocusPosition autofocusPosition) async {}
}
