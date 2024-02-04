import 'package:conductor/conductor.dart';

class CCarrier {
  List<CAction> actions = [];
  List<CReaction> reactions = [];

  CCarrier();

  // for now we are keeping pop logic simple
  CAction? pop() => actions.isEmpty ? null : actions.removeAt(0);
}
