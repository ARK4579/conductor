import 'package:conductor/conductor.dart';

class Dataset {
  static final Map<String, int> _signals = {};
  static Map<String, int> get signals => _signals;

  static void setSignal(String signalName, {int? signalValue}) {
    _signals[signalName] = signalValue ?? DateTime.now().millisecondsSinceEpoch;
  }

  //
  // Global Signals
  //

  static const String signalCurrentDateTime = 'currentDateTime';

  static DateTime? _currentDateTime;
  static DateTime? get currentDateTime => _currentDateTime;
  static set currentDateTime(DateTime? currentDateTime) {
    _currentDateTime = currentDateTime;

    Dataset.setSignal(signalCurrentDateTime);
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
