import 'log_level.dart';
import 'logger_channel.dart';

class LoggerTopic<C extends LoggerChannel> {
  final LogLevel level;

  const LoggerTopic({required this.level});
}
