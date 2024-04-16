import 'package:conductor/conductor.dart';

abstract class CAction {
  String get name => runtimeType.toString();

  List<CTransition> get transitions => [];

  @override
  String toString() {
    return name;
  }
}
