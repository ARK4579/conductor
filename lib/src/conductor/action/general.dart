import 'package:conductor/conductor.dart';

class TimerIntervalCoreAction extends CAction {
  @override
  bool get recurringAction => true;
}

class PushRouterCoreAction extends CAction {
  final CoreUrl url;
  PushRouterCoreAction({
    required this.url,
  });

  @override
  List<CTransition> get transitions => [
        PushCoreGeneralTransition(triggererAction: this),
      ];
}

class PopRouterCoreAction extends CAction {
  @override
  List<CTransition> get transitions => [
        PopCoreGeneralTransition(triggererAction: this),
      ];
}
