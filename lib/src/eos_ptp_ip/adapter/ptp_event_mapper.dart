import '../../common/models/camera_update_event.dart';
import '../communication/events/allowed_values_changed.dart';
import '../communication/events/prop_value_changed.dart';
import '../communication/events/ptp_event.dart';

class PtpEventMapper {
  const PtpEventMapper();

  CameraUpdateEvent? mapToCommon(PtpEvent ptpEvent) {
    switch (ptpEvent) {
      case PropValueChanged(:final propType?, :final propValue):
        return CameraUpdateEvent.propValueChanged(propType, propValue);
      case AllowedValuesChanged(:final propType?, :final allowedValues):
        return CameraUpdateEvent.propAllowedValuesChanged(
            propType, allowedValues);
    }

    return null;
  }
}
