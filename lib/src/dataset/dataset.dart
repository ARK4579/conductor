import 'package:conductor/conductor.dart';

class Dataset {
  // make Dateset singleton so that we can easily access it from anywhere as well as extend
  static final Dataset _instance = Dataset._internal();
  factory Dataset() {
    return _instance;
  }
  Dataset._internal();

  final Map<String, Signal> _signals = {};
  Map<String, Signal> get signals => _signals;

  String? lastSignal;
  void setSignal(Signal signal) {
    if (lastSignal != signal.name) mLog("---$signal", print: CConductor.printLogsToConsole, file: CConductor.printLogsToFile);
    lastSignal = signal.name;
    signal.at = DateTime.now().millisecondsSinceEpoch;
    _signals[signal.name] = signal;
  }

  //
  // Global Signals
  //

  static DateTimeRange? _currentDateTimeQuaterRange;
  DateTimeRange? get currentDateTimeQuaterRange => _currentDateTimeQuaterRange;

  DateTime? _currentDateTime;
  DateTime? get currentDateTime => _currentDateTime;
  set currentDateTime(DateTime? currentDateTime) {
    _currentDateTime = currentDateTime;

    if (currentDateTime != null) {
      final rangeStartTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        currentDateTime.hour,
        (currentDateTime.minute ~/ 15) * 15,
      );
      final newCurrentDateTimeQuaterRange = DateTimeRange(
        start: rangeStartTime,
        end: rangeStartTime.add(const Duration(minutes: 15)),
      );
      if (_currentDateTimeQuaterRange != newCurrentDateTimeQuaterRange) {
        _currentDateTimeQuaterRange = newCurrentDateTimeQuaterRange;
        CurrentDateTimeQuaterRangeSignal().set();
      }
    }

    CurrentDateTimeSignal().set();
  }

  //
  // Queue Helpers
  //

  static final Queue<CAction> _actionsQueue = Queue<CAction>();
  static CAction? getActions() => _actionsQueue.isNotEmpty ? _actionsQueue.removeFirst() : null;
  static void addAction(CAction action) {
    _actionsQueue.addLast(action);
  }
}
