import 'package:conductor/conductor.dart';

abstract class CReaction {
  void react() {
    mLog('$runtimeType');
  }
}
