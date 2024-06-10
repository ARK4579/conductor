import 'package:conductor/conductor.dart';

abstract class CReaction {
  void react() {
    mLog('$runtimeType', print: CConductor.printLogsToConsole, file: CConductor.printLogsToFile);
  }
}
