import 'package:conductor/conductor.dart';

String timerIntervalCoreActionI = "TimerIntervalCoreAction";
String popRouterCoreActionI = "PopRouterCoreAction";

class TimerIntervalCoreAction extends CAction {
  @override
  String get identifier => timerIntervalCoreActionI;
}

class PopRouterCoreAction extends CAction {
  @override
  String get identifier => popRouterCoreActionI;
}
