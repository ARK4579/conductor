import 'package:conductor/conductor.dart';

class CConductor {
  final CAction starter;
  const CConductor({
    required this.starter,
  });

  List<CGame> get coreGames => [
        CoreGeneralGame(),
      ];

  static final List<CGame> _conductorGames = [];
  static void addConductorGame(CGame game) {
    _conductorGames.add(game);
  }

  List<CGame> get games => coreGames + _conductorGames;

  void conduct() {
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
