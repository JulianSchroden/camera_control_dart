import '../../demo/discovery/demo_discovery_adapter.dart';
import '../../eos_cine_http/discovery/eos_cine_http_camera_discovery_adapter.dart';
import '../../eos_ptp_ip/discovery/eos_ptp_ip_camera_discovery_adapter.dart';
import 'camera_discovery.dart';
import 'camera_discovery_adapter.dart';
import 'upnp/upnp_discovery_adapter.dart';
import 'wifi_info_adapter.dart';

class CameraDiscoveryConfigurator {
  final List<CameraDiscoveryAdapter> _discoveryAdapters = [];

  CameraDiscoveryConfigurator withEosPtpIp([
    UpnpDiscoveryAdapter? upnpDiscoveryAdapter,
  ]) {
    _discoveryAdapters.add(EosPtpIpCameraDiscoveryAdapter(
      upnpDiscoveryAdapter ?? UpnpDiscoveryAdapter(),
    ));
    return this;
  }

  CameraDiscoveryConfigurator withEosCineHttp(
    WifiInfoAdapter wifiInfoAdapter,
  ) {
    _discoveryAdapters.add(EosCineHttpCameraDiscoveryAdapter(
      wifiInfoAdapter,
    ));
    return this;
  }

  CameraDiscoveryConfigurator withDemo({
    Duration aliveMessageInterval = const Duration(seconds: 5),
  }) {
    _discoveryAdapters.add(DemoDiscoveryAdapter(
      aliveMessageInterval: aliveMessageInterval,
    ));
    return this;
  }

  CameraDiscovery create() {
    return CameraDiscovery(_discoveryAdapters);
  }
}
