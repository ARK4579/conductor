import 'package:conductor/conductor.dart';

abstract class CGame {
  // Map<String, Type> get map;
  CTransition? getTransition(CAction action);

  void loop(CCarrier carrier, CAction starter) {
    List<CAction> actions = [starter];
    while (actions.isNotEmpty) {
      // get next action and transaction for that action
      CAction? nextAktion = actions.removeAt(0);
      CTransition? transition = getTransition(nextAktion);

      mLog("${starter.runtimeType}@$runtimeType->${transition.runtimeType}");

      // if transaction is null, then move to next action
      if (transition == null) {
        continue;
      }

      transition.transit();

      actions.addAll(transition.actions);
      carrier.actions.addAll(transition.carryActions);
      carrier.reactions.addAll(transition.reactions);
    }
  }
}
