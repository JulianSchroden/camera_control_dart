import 'common/camera.dart';
import 'common/camera_config.dart';
import 'common/camera_factory.dart';
import 'common/discovery/camera_discovery.dart';
import 'common/discovery/camera_discovery_configurator.dart';
import 'common/discovery/camera_discovery_event.dart';
import 'common/logging/camera_control_logger.dart';
import 'common/logging/camera_control_logger_config.dart';
import 'common/logging/logger_topic.dart';
import 'common/models/camera_connection_handle.dart';
import 'common/models/camera_control_protocol.dart';
import 'common/models/camera_model.dart';
import 'demo/demo_camera_factory.dart';
import 'eos_cine_http/eos_cine_http_camera_factory.dart';
import 'eos_ptp_ip/eos_ptp_ip_camera_factory.dart';

class CameraControl {
  final CameraDiscovery _cameraDiscovery;

  const CameraControl(this._cameraDiscovery);

  static CameraControlConfigurator init() => CameraControlConfigurator();

  Stream<CameraDiscoveryEvent> discover() => _cameraDiscovery.discover();

  Future<void> pair(CameraConnectionHandle connectionHandle) async {
    final factory = _provideFactory(connectionHandle.model);
    await factory.pair(connectionHandle);
  }

  Future<Camera> connect(
    CameraConnectionHandle connectionHandle, [
    CameraConfig config = const CameraConfig(),
  ]) async {
    final factory = _provideFactory(connectionHandle.model);
    return await factory.connect(connectionHandle, config);
  }

  CameraFactory _provideFactory(CameraModel model) {
    switch (model.protocol) {
      case CameraControlProtocol.demo:
        return DemoCameraFactory();
      case CameraControlProtocol.eosCineHttp:
        return EosCineHttpCameraFactory();
      case CameraControlProtocol.eosPtpIp:
        return EosPtpIpCameraFactory();
    }
  }
}

class CameraControlConfigurator {
  final CameraDiscoveryConfigurator _discoveryConfigurator =
      CameraDiscoveryConfigurator();

  CameraControlConfigurator withDiscovery(
    void Function(CameraDiscoveryConfigurator discovery) discoverySetup,
  ) {
    discoverySetup(_discoveryConfigurator);
    return this;
  }

  CameraControlConfigurator withLogging({
    required CameraControlLogger logger,
    required List<LoggerTopic> enabledTopics,
  }) {
    CameraControlLoggerConfig.init(
      logger: logger,
      enabledTopics: enabledTopics,
    );
    return this;
  }

  CameraControl create() {
    return CameraControl(_discoveryConfigurator.create());
  }
}
