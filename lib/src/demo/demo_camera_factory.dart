import '../common/camera.dart';
import '../common/camera_config.dart';
import '../common/camera_factory.dart';
import '../common/models/camera_connection_handle.dart';
import 'demo_camera.dart';

class DemoCameraFactory extends CameraFactory {
  @override
  Future<Camera> connect(
      CameraConnectionHandle handle, CameraConfig config) async {
    return DemoCamera(config);
  }
}
