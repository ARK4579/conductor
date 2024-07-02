import 'package:conductor/conductor.dart';

abstract class CAction {
  String get name => runtimeType.toString();

  List<CTransition> _transitions = [];
  List<CTransition> get transitions => _transitions;
  set transitions(List<CTransition> transitions) {
    _transitions = transitions;
  }

  @override
  String toString() {
    return name;
  }
}
