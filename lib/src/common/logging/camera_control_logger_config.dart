import 'log_level.dart';
import 'logger.dart';
import 'logger_channel.dart';
import 'logger_topic.dart';

class UnspecifiedChannel extends LoggerChannel {
  const UnspecifiedChannel();
}

class UnspecifiedLoggerTopic extends LoggerTopic<UnspecifiedChannel> {
  /// Fallback LoggerTopic.
  ///
  /// UnspecifiedLoggerTopic is used to ensure logging calls which do not specify
  /// a [LoggerChannel] are logged.
  const UnspecifiedLoggerTopic({super.level = LogLevel.info});
}

class NeverLoggingLogger implements Logger {
  /// Logger implementation, which swallows any call.
  ///
  /// Use NeverLoggingLogger to ensure camera_control_dart does not print any output.
  const NeverLoggingLogger();

  @override
  void info<C extends LoggerChannel>(
    message, [
    error,
    StackTrace? stackTrace,
  ]) {}

  @override
  void log<C extends LoggerChannel>(
    LogLevel level,
    message, [
    error,
    StackTrace? stackTrace,
  ]) {}

  @override
  void warning<C extends LoggerChannel>(
    message, [
    error,
    StackTrace? stackTrace,
  ]) {}
}

/// The global config for the [CameraControlLogger].
///
/// This config is used to enable specific logging topics for debugging purposes.
class CameraControlLoggerConfig {
  static CameraControlLoggerConfig? _instance;
  static CameraControlLoggerConfig? get instance => _instance;

  Logger logger = const NeverLoggingLogger();
  List<LoggerTopic> _enabledTopics = [];

  /// Initializes the CameraControlLoggerConfig [instance] and sets the enabled topics.
  ///
  /// Use the [enabledTopics] list to configure the logging output.
  static void init({
    required Logger logger,
    required List<LoggerTopic> enabledTopics,
  }) {
    _instance = CameraControlLoggerConfig();
    _instance!.logger = logger;
    _instance!._enabledTopics = [
      ...enabledTopics,
      const UnspecifiedLoggerTopic(),
    ];
  }

  List<LoggerTopic> get enabledTopics => _enabledTopics;
}
