import 'package:conductor/conductor.dart';

abstract class CGame {
  // while now action can have their own transitions
  // games are really helpful for when you can't/don't want to change action transitions
  // e.g. while a core action can define it's own transitions you might want to use it in your app too
  // but you can't really change the transitions of the core action, so can can use a game to trigger additional transitions for that action

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

      for (CAction action in transition.actions) {
        mLog("${transition.runtimeType}=>$action");
      }
      for (CAction action in transition.carryActions) {
        mLog("${transition.runtimeType}===>$action");
      }
      actions.addAll(transition.actions);
      carrier.actions.addAll(transition.carryActions);
      carrier.reactions.addAll(transition.reactions);
    }
  }
}
