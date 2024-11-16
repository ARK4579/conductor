import 'package:conductor/conductor.dart';

abstract class CGame {
  // while now action can have their own transitions
  // games are really helpful for when you can't/don't want to change action transitions
  // e.g. while a core action can define it's own transitions you might want to use it in your app too
  // but you can't really change the transitions of the core action, so can can use a game to trigger additional transitions for that action

  CTransition? getTransition(CAction action);
}
