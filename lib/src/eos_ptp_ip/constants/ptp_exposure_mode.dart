import '../../../camera_control_dart.dart';
import '../../common/extensions/list_extensions.dart';
import 'ptp_property.dart';

enum PtpExposureMode implements EosValue {
  program(native: 0x00, shortName: 'P'),
  shutterPriority(native: 0x01, shortName: 'TV'),
  aperturePriority(native: 0x02, shortName: 'AV'),
  manual(native: 0x03, shortName: 'M'),
  bulb(native: 0x04, shortName: 'B'),
  auto(native: 0x16, shortName: 'A+'),
  scene(native: 0x2d, shortName: 'SCN'),
  creative(native: 0x1e, shortName: ''),
  flexAuto(native: 0x37, shortName: 'Fv');

  @override
  final int native;

  @override
  String get common => name;

  final String shortName;

  const PtpExposureMode({required this.native, required this.shortName});
}

extension PtpExposureModeToCommonExtension on PtpExposureMode {
  ExposureMode toCommon() => switch (this) {
        PtpExposureMode.manual => ExposureMode.manual,
        PtpExposureMode.aperturePriority => ExposureMode.aperturePriority,
        PtpExposureMode.shutterPriority => ExposureMode.shutterPriority,
        PtpExposureMode.bulb => ExposureMode.bulb,
        PtpExposureMode.flexAuto => ExposureMode.flexAuto,
        _ => ExposureMode.notSupported,
      };
}

PtpExposureMode? mapPtpExposureMode(int exposureModeValue) {
  return PtpExposureMode.values
      .firstWhereOrNull((e) => e.native == exposureModeValue);
}
