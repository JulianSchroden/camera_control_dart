import '../../../camera_control_dart.dart';
import '../../common/discovery/camera_discovery_adapter.dart';
import 'demo_discovery_handle.dart';

class DemoDiscoveryAdapter extends CameraDiscoveryAdapter {
  final Duration aliveMessageInterval;

  DemoDiscoveryAdapter({required this.aliveMessageInterval});

  @override
  Stream<CameraDiscoveryEvent> discover() => Stream.periodic(
        aliveMessageInterval,
        (_) => CameraDiscoveryEvent.alive(
          handle: DemoDiscoveryHandle(
            id: CameraId.demoCamera,
            model: CameraModels.demoCamera,
          ),
        ),
      );
}
