import 'package:conductor/conductor.dart';

abstract class CConductor {
  static List<CGame> get coreGames => [
        CoreGeneralGame(),
      ];

  static final List<CGame> _conductorGames = [];
  static void addConductorGame(CGame game) {
    _conductorGames.add(game);
  }

  static List<CGame> get games => coreGames + _conductorGames;

  static void conduct(CAction starter) {
    CCarrier carrier = CCarrier()
      ..actions = [
        starter,
      ];
    mLog(">>>${starter.runtimeType}");

    // loop through all action transactions and all games until there are no more actions
    while (carrier.actions.isNotEmpty) {
      CAction action = carrier.actions.removeAt(0);
      // first we loop through all actions transitions
      loop(carrier, action);
      // then we loop through all games
      for (CGame game in games) {
        game.loop(carrier, action);
      }
    }

    // react to all reactions
    for (CReaction reaction in carrier.reactions) {
      reaction.react();
    }
  }

  static void loop(CCarrier carrier, CAction starter) {
    List<CAction> actions = [starter];
    while (actions.isNotEmpty) {
      // get next action and transaction for that action
      CAction? nextAktion = actions.removeAt(0);
      List<CTransition> transitions = nextAktion.transitions;

      for (final transition in transitions) {
        mLog("$nextAktion->${transition.runtimeType}");

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
}
