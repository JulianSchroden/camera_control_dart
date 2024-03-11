import '../../camera_control_dart.dart';
import 'extensions/list_extensions.dart';

abstract class CameraId {
  CameraId._();

  static const demoCamera = "demoCamera";
  static const canonC100II = "CanonC100II";
  static const canon70D = "Canon70D";

  static List<String> values = [demoCamera, canonC100II, canon70D];
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

  static const List<CameraModel> values = [
    demoCamera,
    canonC100II,
    canon70D,
  ];

  static CameraModel? findByName(String modelName) =>
      values.firstWhereOrNull((model) => model.name == modelName);
}

abstract class CameraFactory<Pd extends PairingData> {
  const CameraFactory();

  Future<void> pair(CameraConnectionHandle handle) async {}
  Future<Camera> connect(CameraConnectionHandle handle);
}
