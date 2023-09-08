import 'package:logging/logging.dart';
import 'package:loggy/loggy.dart';

final Map<Level, LogLevel> logLevelMap = {
  Level.ALL: LogLevel.all,
  Level.INFO: LogLevel.info,
  Level.CONFIG: LogLevel.info,
  Level.SHOUT: LogLevel.error,
  Level.SEVERE: LogLevel.error,
  Level.WARNING: LogLevel.warning,
  Level.FINE: LogLevel.debug,
  Level.FINER: LogLevel.debug,
  Level.FINEST: LogLevel.debug,
  Level.OFF: LogLevel.off,
};

mixin LoggerMixin {
  Logger get logger => Logger(runtimeType.toString());
}
