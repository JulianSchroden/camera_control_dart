import 'package:freezed_annotation/freezed_annotation.dart';

import '../property_control/control_prop_type.dart';
import '../property_control/control_prop_value.dart';
import 'camera_descriptor.dart';
import 'properties/auto_focus_mode.dart';

part 'camera_update_event.freezed.dart';

@freezed
class CameraUpdateEvent with _$CameraUpdateEvent {
  const factory CameraUpdateEvent.descriptorChanged(
      CameraDescriptor descriptor) = _DescriptorChanged;
  const factory CameraUpdateEvent.propValueChanged(
      ControlPropType propType, ControlPropValue value) = _PropValueChanged;
  const factory CameraUpdateEvent.propAllowedValuesChanged(
          ControlPropType propType, List<ControlPropValue> allowedValues) =
      _PropAllowedValuesChanged;
  const factory CameraUpdateEvent.recordState(bool isRecording) =
      _RecordStateUpdate;
  const factory CameraUpdateEvent.focusMode(AutoFocusMode focusMode) =
      _FocusModeUpdate;
  const factory CameraUpdateEvent.ndFilter(int ndValue) = _NdFilterUpdate;
}
