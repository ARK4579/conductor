import 'package:conductor/conductor.dart';

class _MyLogger {
  late final Logger logger;

  _MyLogger._privateConstructor() {
    // For non-root loggers, this is required to change level
    hierarchicalLoggingEnabled = true;
    logger = Logger('core')
      ..level = Level.ALL
      ..onRecord.listen((record) {
        if (kDebugMode) {
          print('${record.level.name}: ${record.time}: ${record.message}');
        }
      });
  }
  static final _MyLogger _instance = _MyLogger._privateConstructor();

  factory _MyLogger() {
    return _instance;
  }

  static void logInfo(String message) {
    if (!kDebugMode) return;
    _instance.logger.info(message);
  }

  static void logWarning(String message) {
    if (!kDebugMode) return;
    _instance.logger.warning(message);
  }

  static void logSevere(String message) {
    if (!kDebugMode) return;
    _instance.logger.severe(message);
  }
}

mLog(String message) => _MyLogger.logInfo(message);
mWarn(String message) => _MyLogger.logWarning(message);
