import 'package:conductor/conductor.dart';

class TimerIntervalCoreAction extends CAction {
  @override
  bool get recurringAction => true;
}

class PopRouterCoreAction extends CAction {
  @override
  List<CTransition> get transitions => [
        PopCoreGeneralTransition(triggererAction: this),
      ];
}
