import 'camera_discovery_event.dart';
import 'wifi_info.dart';

abstract class CameraDiscoveryService {
  Future<WifiInfo> wifiInfo();

  Stream<CameraDiscoveryEvent> discover();
}
