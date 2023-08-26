import 'package:rxdart/rxdart.dart';

import '../../common/discovery/wifi_info_adapter.dart';
import '../../eos_cine_http/discovery/eos_cine_http_camera_discovery_adapter.dart';
import '../../eos_ptp_ip/discovery/eos_ptp_ip_camera_discovery_adapter.dart';
import 'camera_discovery_adapter.dart';
import 'camera_discovery_event.dart';
import 'upnp/upnp_discovery_adapter.dart';
import 'wifi_info.dart';

class CameraDiscoveryService {
  final WifiInfoAdapter wifiInfoAdapter;
  final UpnpDiscoveryAdapter upnpDiscoveryAdapter;

  CameraDiscoveryService({
    required this.wifiInfoAdapter,
    List<CameraDiscoveryAdapter>? discoveryAdapters,
    UpnpDiscoveryAdapter? upnpDiscoveryAdapter,
  }) : upnpDiscoveryAdapter = upnpDiscoveryAdapter ?? UpnpDiscoveryAdapter();

  Future<WifiInfo> wifiInfo() async {
    final localIp = await wifiInfoAdapter.getLocalIp();
    final gatewayIp = await wifiInfoAdapter.getGatewayIp();

    return WifiInfo(localIp, gatewayIp);
  }

  Stream<CameraDiscoveryEvent> discover() {
    return MergeStream([
      EosPtpIpCameraDiscoveryAdapter(upnpDiscoveryAdapter).discover(),
      EosCineHttpCameraDiscoveryAdapter(wifiInfoAdapter).discover(),
    ]);
  }
}
