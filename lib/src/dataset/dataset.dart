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

  static const String signalCurrentDateTime = 'currentDateTime';

  DateTime? _currentDateTime;
  DateTime? get currentDateTime => _currentDateTime;
  set currentDateTime(DateTime? currentDateTime) {
    _currentDateTime = currentDateTime;

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
