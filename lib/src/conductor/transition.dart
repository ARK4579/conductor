import 'package:conductor/conductor.dart';

enum CTransitionResults {
  notExecuted,
  success,
  failure,
}

abstract class CTransition<T extends CAction> {
  final T triggererAction;
  CTransition({required this.triggererAction});

  // success
  List<CAction> get successActions => [];
  List<CAction> successAdditionalActions = [];
  List<CReaction> get successReactions => [];
  List<CAction> get successCarryActions => [];

  // faliure
  List<CAction> get faliureActions => [];
  List<CAction> faliureAdditionalActions = [];
  List<CReaction> get faliureReactions => [];
  List<CAction> get faliureCarryActions => [];

  CTransitionResults result = CTransitionResults.notExecuted;

  bool? condition() => null;

  void transit() {
    bool? conditionResult = condition();

    // if condition is overrideen, then use that only
    if (conditionResult != null) {
      result = conditionResult ? CTransitionResults.success : CTransitionResults.failure;
      return;
    }

    subTransit();
    result = CTransitionResults.success;
  }

  void subTransit() {}

  List<CAction> get actions => result == CTransitionResults.notExecuted
      ? []
      : result == CTransitionResults.success
          ? successActions + successAdditionalActions
          : faliureActions + faliureAdditionalActions;
  List<CReaction> get reactions => result == CTransitionResults.notExecuted
      ? []
      : result == CTransitionResults.success
          ? successReactions
          : faliureReactions;
  List<CAction> get carryActions => result == CTransitionResults.notExecuted
      ? []
      : result == CTransitionResults.success
          ? successCarryActions
          : faliureCarryActions;
}
