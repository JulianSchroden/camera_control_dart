import '../../../common/logging/base_camera_control_logger.dart';
import '../../../common/logging/log_level.dart';
import '../../../common/logging/logger_channel.dart';
import '../../../common/logging/logger_topic.dart';

class EosDiscoveryChannel extends LoggerChannel {
  const EosDiscoveryChannel();
}

class EosPtpIpDiscoveryTopic extends LoggerTopic<EosDiscoveryChannel> {
  const EosPtpIpDiscoveryTopic({super.level = LogLevel.info});
}

mixin EosPtpIpDiscoveryLogger on BaseCameraControlLogger {
  void logCameraAlive(String uniqueDeviceName) {
    whenTopicEnabled<EosPtpIpDiscoveryTopic>((topic) {
      log(topic.level, 'Camera alive: $uniqueDeviceName');
    });
  }

  void logCameraByeBye(String uniqueDeviceName) {
    whenTopicEnabled<EosPtpIpDiscoveryTopic>((topic) {
      log(topic.level, 'Camera byeBye: $uniqueDeviceName');
    });
  }
}
