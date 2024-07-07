import '../communication/events/prop_value_changed.dart';
import '../constants/properties/movie_recording_status.dart';
import '../constants/ptp_property.dart';
import '../models/eos_ptp_int_prop_value.dart';
import '../models/eos_sensor_info.dart';
import '../models/eos_sensor_info_prop_value.dart';
import 'ptp_property_cache.dart';

extension PtpPropertyCacheSensorInfoExtension on PtpPropertyCache {
  void updateSensorInfo(EosSensorInfo sensorInfo) {
    update([
      PropValueChanged(
        PtpPropertyCode.liveViewSensorResolution,
        null,
        EosSensorInfoPropValue(sensorInfo),
      )
    ]);
  }

  EosSensorInfo? getSensorInfo() {
    return getValueByPropCode<EosSensorInfoPropValue>(
            PtpPropertyCode.liveViewSensorResolution)
        ?.sensorInfo;
  }
}

extension PtpPropertyCacheIsRecordingExtension on PtpPropertyCache {
  bool get isRecording =>
      getValueByPropCode<EosPtpIntPropValue>(
              PtpPropertyCode.movieRecordingStatus)
          ?.nativeValue ==
      MovieRecordingStatus.recording.native;
}
