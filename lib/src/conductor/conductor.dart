import 'package:conductor/conductor.dart';

abstract class CConductor {
  static bool printLogsToConsole = false;
  static bool printLogsToFile = true;
  static List<CGame> get coreGames => [
        CoreGeneralGame(),
      ];

  static final List<CGame> _conductorGames = [];
  static void addConductorGame(CGame game) {
    _conductorGames.add(game);
  }

  static List<CGame> get games => coreGames + _conductorGames;

  static void conduct(CAction starter) async {
    CCarrier carrier = CCarrier()
      ..actions = [
        starter,
      ];
    mLog(">>>${starter.runtimeType}", print: printLogsToConsole, file: printLogsToFile);

    // loop through all action transactions and all games until there are no more actions
    while (carrier.actions.isNotEmpty) {
      CAction action = carrier.actions.removeAt(0);
      // first we loop through all actions transitions
      await loop(carrier, action);
      // then we loop through all games
      action.transitions.removeWhere((_) => true);
      for (CGame game in games) {
        CTransition? gapTransition = game.getTransition(action);
        if (gapTransition != null) {
          action.transitions.add(gapTransition);
        }
      }
      if (action.transitions.isNotEmpty) {
        await loop(carrier, action);
      }
    }

    // react to all reactions
    for (CReaction reaction in carrier.reactions) {
      reaction.react();
    }
  }

  static Future<void> loop(CCarrier carrier, CAction starter) async {
    List<CAction> actions = [starter];
    while (actions.isNotEmpty) {
      // get next action and transaction for that action
      CAction? nextAktion = actions.removeAt(0);
      List<CTransition> transitions = nextAktion.transitions;

      for (final transition in transitions) {
        mLog("$nextAktion->${transition.runtimeType}", print: printLogsToConsole, file: printLogsToFile);

        await transition.transit();

        for (CAction action in transition.actions) {
          mLog("${transition.runtimeType}=>$action", print: printLogsToConsole, file: printLogsToFile);
        }
        if (transition.actions.isEmpty) {
          mLog("${transition.runtimeType}=>.", print: printLogsToConsole, file: printLogsToFile);
        }
        for (CAction action in transition.carryActions) {
          mLog("${transition.runtimeType}===>$action", print: printLogsToConsole, file: printLogsToFile);
        }
        actions.addAll(transition.actions);
        carrier.actions.addAll(transition.carryActions);
        carrier.reactions.addAll(transition.reactions);
      }
    }
  }
}
