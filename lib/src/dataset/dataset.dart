import 'package:conductor/conductor.dart';

class Dataset {
  // make Dateset singleton so that we can easily access it from anywhere as well as extend
  static final Dataset _instance = Dataset._internal();
  factory Dataset() {
    return _instance;
  }
  Dataset._internal();

  final Map<String, int> _signals = {};
  Map<String, int> get signals => _signals;

  void setSignal(String signalName, {int? signalValue}) {
    _signals[signalName] = signalValue ?? DateTime.now().millisecondsSinceEpoch;
  }

  //
  // Global Signals
  //

  static const String signalCurrentDateTimeQuaterRange =
      'signalCurrentDateTimeQuaterRange';
  static DateTimeRange? _currentDateTimeQuaterRange;
  DateTimeRange? get currentDateTimeQuaterRange => _currentDateTimeQuaterRange;

  static const String signalCurrentDateTime = 'currentDateTime';
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
        Dataset().setSignal(signalCurrentDateTimeQuaterRange);
      }
    }

    Dataset().setSignal(signalCurrentDateTime);
  }

  //
  // Queue Helpers
  //

  static final Queue<CAction> _actionsQueue = Queue<CAction>();
  static CAction? getActions() =>
      _actionsQueue.isNotEmpty ? _actionsQueue.removeFirst() : null;
  static void addAction(CAction action) {
    _actionsQueue.addLast(action);
  }
}
