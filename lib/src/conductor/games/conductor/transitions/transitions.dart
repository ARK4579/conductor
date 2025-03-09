import 'package:conductor/conductor.dart';

class TimerIntervalCoreGeneralTransition extends CTransition {
  final TimerIntervalCoreAction triggererAction;
  TimerIntervalCoreGeneralTransition({required this.triggererAction});

  @override
  List<CReaction> get successReactions => [
        DoNothingSuccessCoreReaction(),
      ];
}

class PushCoreGeneralTransition extends CTransition {
  final PushRouterCoreAction triggererAction;
  PushCoreGeneralTransition({required this.triggererAction});

  @override
  List<CReaction> get successReactions => [
        PushRouterCoreReaction(url: triggererAction.url),
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
