import '../../../camera_control_dart.dart';
import '../../common/models/camera_update_event.dart';
import '../communication/events/allowed_values_changed.dart';
import '../communication/events/prop_value_changed.dart';
import '../communication/events/ptp_event.dart';
import '../constants/properties/movie_recording_status.dart';
import '../constants/ptp_property.dart';
import '../models/eos_ptp_int_prop_value.dart';
import 'ptp_descriptor_mapper.dart';

class PtpEventMapper {
  final PtpDescriptorMapper _ptpDescriptorMapper;

  PtpEventMapper(this._ptpDescriptorMapper);

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
        PropValueChanged(
          propCode: PtpPropertyCode.exposureMode || PtpPropertyCode.liveViewMode
        ) =>
          CameraUpdateEvent.descriptorChanged(
            _ptpDescriptorMapper.mapDescriptor(),
          ),
        AllowedValuesChanged(
          :final propType?,
          :final allowedValues,
        ) =>
          CameraUpdateEvent.propAllowedValuesChanged(propType, allowedValues),
        _ => null,
      };
}
