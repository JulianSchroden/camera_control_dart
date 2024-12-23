import 'live_view/live_view_data.dart';
import 'models/camera_descriptor.dart';
import 'models/camera_update_event.dart';
import 'models/properties/autofocus_position.dart';
import 'property_control/control_prop.dart';
import 'property_control/control_prop_type.dart';
import 'property_control/control_prop_value.dart';

abstract class Camera {
  Camera();

  Future<void> close();
  Future<void> disconnect();

  Future<CameraDescriptor> getDescriptor();
  Future<ControlProp?> getProp(ControlPropType propType);
  Future<void> setProp(ControlPropType propType, ControlPropValue propValue);

  Future<void> captureImage();
  Future<void> triggerRecord();
  Future<void> toggleAfLock();

  Stream<CameraUpdateEvent> events();

  set pollInterval(interval);
  Duration get pollInterval;

  Stream<LiveViewData> liveView();

  Future<void> setAutofocusPosition(AutofocusPosition autofocusPosition);
}
