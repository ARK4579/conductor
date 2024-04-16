import 'package:conductor/conductor.dart';

abstract class CAction {
  String get identifier;

  List<CTransition> get transitions => [];
}
