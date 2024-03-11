import '../../common/discovery/discovery_handle.dart';
import '../demo_camera_pairing_data.dart';

class DemoDiscoveryHandle extends DiscoveryHandle {
  const DemoDiscoveryHandle({
    required super.id,
    required super.model,
    super.pairingData = const DemoCameraPairingData(),
  });
}
