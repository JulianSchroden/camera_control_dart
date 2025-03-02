import 'camera.dart';
import 'camera_config.dart';
import 'models/camera_connection_handle.dart';
import 'models/pairing_data.dart';

abstract class CameraFactory<Pd extends PairingData> {
  const CameraFactory();

  Future<void> pair(CameraConnectionHandle handle) async {}
  Future<Camera> connect(CameraConnectionHandle handle, CameraConfig config);
}
