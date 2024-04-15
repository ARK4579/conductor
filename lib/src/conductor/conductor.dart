import 'package:conductor/conductor.dart';

abstract class CConductor {
  // final CAction starter;
  // const CConductor({
  //   required this.starter,
  // });

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

    // loop through all games until there are no more actions
    while (carrier.actions.isNotEmpty) {
      CAction action = carrier.actions.removeAt(0);
      for (CGame game in games) {
        game.loop(carrier, action);
      }
    }

    // react to all reactions
    for (CReaction reaction in carrier.reactions) {
      reaction.react();
    }
  }
}
