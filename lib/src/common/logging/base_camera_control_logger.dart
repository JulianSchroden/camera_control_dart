import '../../interface/logging/camera_control_logger.dart';
import '../../interface/logging/camera_control_logger_config.dart';
import '../../interface/logging/log_level.dart';
import '../../interface/logging/logger.dart';
import '../../interface/logging/logger_channel.dart';
import '../../interface/logging/logger_topic.dart';

class BaseCameraControlLogger extends CameraControlLogger {
  const BaseCameraControlLogger();

  Logger get logger => _config!.logger!;

  @override
  void log<C extends LoggerChannel>(
    LogLevel level,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (isChannelEnabled<C>()) {
      logger.log(level, message, error, stackTrace);
    }
  }

  @override
  void info<C extends LoggerChannel>(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (isChannelEnabled<C>()) {
      logger.info(message, error, stackTrace);
    }
  }

  @override
  void warning<C extends LoggerChannel>(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (isChannelEnabled<C>()) {
      logger.warning(message, error, stackTrace);
    }
  }

  @override
  T? getTopic<T>() {
    try {
      final topic = _config?.enabledTopics.firstWhere((topic) => topic is T);

      return topic == null ? null : topic as T;
    } catch (e) {
      return null;
    }
  }

  @override
  bool isTopicEnabled<T>() {
    try {
      final topic = _config?.enabledTopics.firstWhere((topic) => topic is T);
      return topic != null;
    } catch (e) {
      return false;
    }
  }

  @override
  void whenTopicEnabled<T>(void Function(T topic) callback) {
    final topic = getTopic<T>();
    if (topic != null) {
      callback(topic);
    }
  }

  @override
  bool isChannelEnabled<C extends LoggerChannel>() {
    try {
      final topicOfChannel = _config?.enabledTopics.firstWhere(
        (topic) => topic is LoggerTopic<C>,
      );
      return topicOfChannel != null;
    } catch (e) {
      return false;
    }
  }

  CameraControlLoggerConfig? get _config => CameraControlLoggerConfig.instance;
}
