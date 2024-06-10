import 'package:conductor/conductor.dart';

extension LogRecordLine on LogRecord {
  String get logLine => '$time [${level.name}] $message';
}

String? lineTerminator() {
  if (isLinux || isFuchsia) {
    return "\n";
  }
  if (isMacOS) {
    return "\r";
  } else if (isWindows) {
    return "\r\n";
  } else {
    return null;
  }
}

class _MyLogger {
  Logger? printLogger;
  Logger? fileLogger;

  File? _fileLoggerFile;
  Future<void> initfileLoggerFile() async {
    if (_fileLoggerFile == null && lineTerminator() != null) {
      final directory = await getTemporaryDirectory();
      String filename = "conductor_log.txt";
      print("Logging to file ${directory.path}/$filename");
      _fileLoggerFile = File('${directory.path}/$filename');
      _fileLoggerFile?.writeAsStringSync("${DateTime.now()}${lineTerminator()}", flush: true);
    }
  }

  String logLine(LogRecord record) => '${record.time} [${record.level.name}] ${record.message}';

  _MyLogger._privateConstructor() {
    // For non-root loggers, this is required to change level
    hierarchicalLoggingEnabled = true;
    if (kDebugMode) {
      printLogger = Logger('core_print')
        ..level = Level.ALL
        ..onRecord.listen((record) {
          // ignore: avoid_print
          print(record.logLine);
        });
      fileLogger = Logger('core_file')
        ..level = Level.ALL
        ..onRecord.listen((record) async {
          // ignore: avoid_print
          _fileLoggerFile?.writeAsStringSync("${record.logLine}${lineTerminator()}", mode: FileMode.append, flush: true);
        });
    }
  }
  static final _MyLogger _instance = _MyLogger._privateConstructor();

  factory _MyLogger() {
    return _instance;
  }

  Future<void> init() async {
    await initfileLoggerFile();
  }

  static void logInfo(String message, {bool print = true, bool file = true}) {
    if (print) _instance.printLogger?.info(message);
    if (file) _instance.fileLogger?.info(message);
  }

  static void logWarning(String message, {bool print = true, bool file = true}) {
    if (print) _instance.printLogger?.warning(message);
    if (file) _instance.fileLogger?.warning(message);
  }

  static void logSevere(String message, {bool print = true, bool file = true}) {
    if (print) _instance.printLogger?.severe(message);
    if (file) _instance.fileLogger?.severe(message);
  }
}

Future<void> loggerInit() async => _MyLogger().init();
mLog(String message, {bool print = true, bool file = true}) => _MyLogger.logInfo(message, print: print, file: file);
mWarn(String message, {bool print = true, bool file = true}) => _MyLogger.logWarning(message, print: print, file: file);
mSevere(String message, {bool print = true, bool file = true}) => _MyLogger.logSevere(message, print: print, file: file);
