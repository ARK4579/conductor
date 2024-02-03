import 'package:conductor/conductor.dart';

//
// DoNothingCoreReaction
// For when you need a reaction for debugging purposes
//

abstract class DoNothingCoreReaction extends CReaction {}

class DoNothingSuccessCoreReaction extends DoNothingCoreReaction {}

class DoNothingFaliureCoreReaction extends DoNothingCoreReaction {}
