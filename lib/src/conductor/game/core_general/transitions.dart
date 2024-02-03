import 'package:conductor/conductor.dart';

class TimerIntervalCoreGeneralTransition extends CTransition {
  TimerIntervalCoreGeneralTransition({required super.triggererAction});

  @override
  List<CReaction> get successReactions => [
        DoNothingSuccessCoreReaction(),
      ];
}

class PopCoreGeneralTransition extends CTransition {
  PopCoreGeneralTransition({required super.triggererAction});

  @override
  List<CReaction> get successReactions => [
        PopRouterCoreReaction(),
      ];
}
