import 'package:conductor/conductor.dart';

import 'transitions.dart';

class CoreGeneralGame extends CGame {
  @override
  CTransition? getTransition(CAction action) {
    switch (action) {
      case final PopRouterCoreAction e:
        return PopCoreGeneralTransition(triggererAction: e);
      default:
    }
    return null;
  }
}
