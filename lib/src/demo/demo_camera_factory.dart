import '../common/camera.dart';
import '../common/camera_factory.dart';
import '../common/models/camera_handle.dart';
import 'demo_camera.dart';

class DemoCameraFactory extends CameraFactory {
  @override
  Future<Camera> connect(CameraHandle handle) async {
    return DemoCamera();
  }
}
