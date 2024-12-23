import 'common/extensions/list_extensions.dart';
import 'common/models/camera_control_protocol.dart';
import 'common/models/camera_model.dart';

abstract class CameraId {
  CameraId._();

  static const demoCamera = "demoCamera";
  static const canonC100II = "CanonC100II";
  static const canon70D = "Canon70D";
  static const canonR7 = "CanonR7";
  static const canonRa = "CanonRa";

  static List<String> values = [demoCamera, canonC100II, canon70D, canonRa];
}

class CameraModels {
  static const demoCamera = CameraModel(
    identifier: CameraId.demoCamera,
    name: 'Demo Camera',
    protocol: CameraControlProtocol.demo,
  );
  static const canonC100II = CameraModel(
    identifier: CameraId.canonC100II,
    name: 'Canon EOS C100 II',
    protocol: CameraControlProtocol.eosCineHttp,
  );
  static const canon70D = CameraModel(
    identifier: CameraId.canon70D,
    name: 'Canon EOS 70D',
    protocol: CameraControlProtocol.eosPtpIp,
  );

  static const canonR7 = CameraModel(
    identifier: CameraId.canonR7,
    name: 'Canon EOS R7',
    protocol: CameraControlProtocol.eosPtpIp,
  );

  static const canonRa = CameraModel(
    identifier: CameraId.canonRa,
    name: 'Canon EOS Ra',
    protocol: CameraControlProtocol.eosPtpIp,
  );
  static const List<CameraModel> values = [
    demoCamera,
    canonC100II,
    canon70D,
    canonR7,
    canonRa,
  ];

  static CameraModel? findByName(String modelName) =>
      values.firstWhereOrNull((model) => model.name == modelName);
}
