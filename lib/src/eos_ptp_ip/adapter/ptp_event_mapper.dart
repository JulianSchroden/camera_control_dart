import 'package:camera_control_dart/src/eos_ptp_ip/constants/properties/movie_recording_status.dart';

import '../../../camera_control_dart.dart';
import '../../common/models/camera_update_event.dart';
import '../communication/events/allowed_values_changed.dart';
import '../communication/events/prop_value_changed.dart';
import '../communication/events/ptp_event.dart';
import '../constants/ptp_property.dart';
import '../models/eos_ptp_int_prop_value.dart';

class PtpEventMapper {
  const PtpEventMapper();

  CameraUpdateEvent? mapToCommon(PtpEvent ptpEvent) => switch (ptpEvent) {
        PropValueChanged(
          :final propType?,
          :final propValue,
        ) =>
          CameraUpdateEvent.propValueChanged(propType, propValue),
        PropValueChanged(
          propCode: PtpPropertyCode.movieRecordingStatus,
          propValue: EosPtpIntPropValue(:final nativeValue),
        ) =>
          CameraUpdateEvent.recordState(
            nativeValue == MovieRecordingStatus.recording.native,
          ),
        AllowedValuesChanged(
          :final propType?,
          :final allowedValues,
        ) =>
          CameraUpdateEvent.propAllowedValuesChanged(propType, allowedValues),
        _ => null,
      };
}
