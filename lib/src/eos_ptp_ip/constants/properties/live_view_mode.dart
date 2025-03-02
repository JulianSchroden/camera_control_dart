import '../../../common/extensions/list_extensions.dart';
import '../../../common/models/properties/camera_mode.dart';
import '../../../common/models/properties/exposure_mode.dart';
import '../ptp_property.dart';

enum LiveViewMode implements EosValue {
  photo(0x1),
  movie(0x2);

  const LiveViewMode(this.native);

  @override
  final int native;

  @override
  String get common => name;
}

extension LiveViewModeToCommon on LiveViewMode {
  CameraMode toCommon(ExposureMode exposureMode) => switch (this) {
        LiveViewMode.photo => CameraMode.photo(exposureMode),
        LiveViewMode.movie => CameraMode.video(exposureMode),
      };
}

LiveViewMode? mapLiveViewMode(int liveViewModeValue) {
  return LiveViewMode.values
      .firstWhereOrNull((e) => e.native == liveViewModeValue);
}
