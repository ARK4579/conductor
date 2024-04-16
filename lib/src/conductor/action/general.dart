import 'package:conductor/conductor.dart';

class TimerIntervalCoreAction extends CAction {}

class PopRouterCoreAction extends CAction {
  @override
  List<CTransition> get transitions => [
        PopCoreGeneralTransition(triggererAction: this),
      ];
}
