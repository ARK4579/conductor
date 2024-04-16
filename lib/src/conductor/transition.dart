import 'package:conductor/conductor.dart';

enum CTransitionResults {
  notExecuted,
  success,
  failure,
}

abstract class CTransition {
  String get name => runtimeType.toString();

  // success
  List<CAction?> get successActions => <CAction?>[];
  List<CAction?> successAdditionalActions = <CAction?>[];
  List<CReaction?> get successReactions => <CReaction?>[];
  List<CAction?> get successCarryActions => <CAction?>[];

  // faliure
  List<CAction?> get faliureActions => <CAction?>[];
  List<CAction?> faliureAdditionalActions = <CAction?>[];
  List<CReaction?> get faliureReactions => <CReaction?>[];
  List<CAction?> get faliureCarryActions => <CAction?>[];

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
          ? successActions.nonNulls.toList() + successAdditionalActions.nonNulls.toList()
          : faliureActions.nonNulls.toList() + faliureAdditionalActions.nonNulls.toList();
  List<CReaction> get reactions => result == CTransitionResults.notExecuted
      ? []
      : result == CTransitionResults.success
          ? successReactions.nonNulls.toList()
          : faliureReactions.nonNulls.toList();
  List<CAction> get carryActions => result == CTransitionResults.notExecuted
      ? []
      : result == CTransitionResults.success
          ? successCarryActions.nonNulls.toList()
          : faliureCarryActions.nonNulls.toList();

  @override
  String toString() {
    return name;
  }
}
