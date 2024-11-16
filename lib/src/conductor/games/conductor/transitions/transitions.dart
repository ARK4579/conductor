import 'package:conductor/conductor.dart';

class TimerIntervalCoreGeneralTransition extends CTransition {
  final TimerIntervalCoreAction triggererAction;
  TimerIntervalCoreGeneralTransition({required this.triggererAction});

  @override
  List<CReaction> get successReactions => [
        DoNothingSuccessCoreReaction(),
      ];
}

class PopCoreGeneralTransition extends CTransition {
  final PopRouterCoreAction triggererAction;
  PopCoreGeneralTransition({required this.triggererAction});

  @override
  List<CReaction> get successReactions => [
        PopRouterCoreReaction(),
      ];
}
