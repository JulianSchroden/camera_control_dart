import '../../camera_control_dart.dart';

abstract class CameraFactory<Pd extends PairingData> {
  const CameraFactory();

  Future<void> pair(CameraConnectionHandle handle) async {}
  Future<Camera> connect(CameraConnectionHandle handle);
}
