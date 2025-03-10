import 'dart:async';

import '../../camera_models.dart';
import '../../common/discovery/camera_discovery_adapter.dart';
import '../../common/discovery/camera_discovery_event.dart';
import '../../common/discovery/upnp/upnp_advertisement_message.dart';
import '../../common/discovery/upnp/upnp_discovery_adapter.dart';
import '../logging/eos_ptp_ip_logger.dart';
import 'eos_ptp_ip_discovery_handle.dart';

class EosPtpIpCameraDiscoveryAdapter extends CameraDiscoveryAdapter {
  static const eosPtpIpService =
      'urn:schemas-canon-com:service:ICPO-WFTEOSSystemService:1';
  final UpnpDiscoveryAdapter upnpDiscoveryAdapter;

  final logger = EosPtpIpLogger();

  EosPtpIpCameraDiscoveryAdapter(this.upnpDiscoveryAdapter);

  @override
  Stream<CameraDiscoveryEvent> discover() {
    return upnpDiscoveryAdapter.discover().transform(
      StreamTransformer.fromHandlers(
        handleData: (upnpMessage, sink) async {
          if (upnpMessage is UpnpAdvertisementAlive) {
            if (upnpMessage.serviceType != eosPtpIpService) {
              return;
            }

            final deviceDescription = await upnpDiscoveryAdapter
                .getDeviceDescription(upnpMessage.location);
            if (deviceDescription == null) {
              return;
            }

            final model = CameraModels.findByName(deviceDescription.modelName);
            if (model == null) {
              logger.logUnsupportedCameraAlive(
                deviceDescription.uniqueDeviceName,
                deviceDescription.modelName,
              );
              return;
            }

            logger.logCameraAlive(deviceDescription.uniqueDeviceName);

            sink.add(CameraDiscoveryEvent.alive(
              handle: EosPtpIpDiscoveryHandle(
                address: deviceDescription.address,
                id: deviceDescription.uniqueDeviceName,
                model: model,
              ),
            ));
          } else if (upnpMessage is UpnpAdvertisementByeBye) {
            if (upnpMessage.serviceType != eosPtpIpService) {
              return;
            }

            logger.logCameraByeBye(upnpMessage.uniqueDeviceName);

            sink.add(CameraDiscoveryEvent.byeBye(
              id: upnpMessage.uniqueDeviceName,
            ));
          }
        },
      ),
    );
  }
}
