import 'package:equatable/equatable.dart';

import 'exposure_mode.dart';

sealed class CameraMode extends Equatable {
  final ExposureMode exposureMode;

  const CameraMode(this.exposureMode);

  const factory CameraMode.photo(ExposureMode exposureMode) = PhotoMode;
  const factory CameraMode.video(ExposureMode exposureMode) = VideoMode;

  @override
  List<Object?> get props => [exposureMode];
}

class PhotoMode extends CameraMode {
  const PhotoMode(super.exposureMode);
}

class VideoMode extends CameraMode {
  const VideoMode(super.exposureMode);
}
