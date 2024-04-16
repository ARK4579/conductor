import 'package:conductor/conductor.dart';

class TimerIntervalCoreAction extends CAction {
  @override
  String get identifier => "TimerIntervalCoreAction";
}

class PopRouterCoreAction extends CAction {
  @override
  String get identifier => "PopRouterCoreAction";

  @override
  List<CTransition> get transitions => [
        PopCoreGeneralTransition(triggererAction: this),
      ];
}
