import 'package:conductor/conductor.dart';

class Dataset {
  static final Map<String, int?> _signals = {};
  static Map<String, int?> get signals => _signals;

  void setSignal(String signalName, {int? signalValue}) {
    _signals[signalName] = signalValue ?? DateTime.now().millisecondsSinceEpoch;
  }

  static final Queue<CAction> _actionsQueue = Queue<CAction>();
  static CAction? getActions() =>
      _actionsQueue.isNotEmpty ? _actionsQueue.removeFirst() : null;
  static void addAction(CAction action) {
    _actionsQueue.addLast(action);
  }
}
