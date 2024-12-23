import '../../common/exceptions/camera_communication_exception.dart';
import '../../common/models/camera_descriptor.dart';
import '../../common/models/capabilities/control_prop_capability.dart';
import '../../common/models/capabilities/image_capture_capability.dart';
import '../../common/models/capabilities/live_view_capability.dart';
import '../../common/models/capabilities/movie_record_capability.dart';
import '../cache/ptp_property_cache.dart';
import '../constants/properties/live_view_mode.dart';
import '../constants/ptp_exposure_mode.dart';
import '../constants/ptp_property.dart';
import '../constants/ptp_property_code.dart';
import '../extensions/int_as_hex_string_extension.dart';
import '../models/eos_ptp_int_prop_value.dart';

class PtpDescriptorMapper {
  final PtpPropertyCache _propertyCache;

  const PtpDescriptorMapper(this._propertyCache);

  int getCachedPropertyValue(int propCode) {
    final cachedValue = _propertyCache.getValueByPropCode(propCode);
    if (cachedValue case EosPtpIntPropValue(:final nativeValue)) {
      return nativeValue;
    }

    throw CameraCommunicationException(
        'Failed to map descriptor: property ${propCode.asHex()} not initialized');
  }

  CameraDescriptor mapDescriptor() {
    final liveViewMode =
        mapLiveViewMode(getCachedPropertyValue(PtpPropertyCode.liveViewMode));
    final exposureMode = mapPtpExposureMode(
        getCachedPropertyValue(PtpPropertyCode.exposureMode));

    if (liveViewMode == null || exposureMode == null) {
      throw CameraCommunicationException(
          'Failed to obtain liveViewMode $liveViewMode or exposureMode $exposureMode');
    }

    return CameraDescriptor(
      mode: liveViewMode.toCommon(exposureMode.toCommon()),
      capabilities: [
        ControlPropCapability(
          supportedProps: _propertyCache.supportedProps(),
        ),
        const LiveViewCapability(
          aspectRatio: 3 / 2,
          supportsTouchAutofocus: true,
        ),
        if (liveViewMode == LiveViewMode.photo) const ImageCaptureCapability(),
        if (liveViewMode == LiveViewMode.movie) const MovieRecordCapility(),
      ],
    );
  }
}
