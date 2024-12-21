import 'package:conductor/conductor.dart';

abstract class CAction {
  String get name => runtimeType.toString();

  List<CTransition> _transitions = [];
  // ignore: unnecessary_getters_setters
  List<CTransition> get transitions => _transitions;
  set transitions(List<CTransition> transitions) {
    _transitions = transitions;
  }

  bool get recurringAction => false;

  @override
  String toString() {
    return name;
  }
}
