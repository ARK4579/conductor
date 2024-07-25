import 'package:conductor/conductor.dart';

enum CTransitionResults {
  notExecuted,
  success,
  failure,
}

abstract class CTransition {
  String get name => runtimeType.toString();

  // any
  List<CAction?> get anyActions => <CAction?>[];
  List<CAction?> anyAdditionalActions = <CAction?>[];
  List<CReaction?> get anyReactions => <CReaction?>[];
  List<CAction?> get anyCarryActions => <CAction?>[];

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

  bool condition() => true;

  Future<void> transit() async {
    bool conditionResult = condition();

    // if condition is overrideen, then use that only
    if (!conditionResult) {
      result = CTransitionResults.failure;
      return;
    }

    subTransit();
    await subTransitAsync();
    result = CTransitionResults.success;
  }

  void subTransit() {}
  Future<void> subTransitAsync() async {}

  List<CAction> get _resultActions => result == CTransitionResults.notExecuted
      ? <CAction>[]
      : result == CTransitionResults.success
          ? successActions.nonNulls.toList() + successAdditionalActions.nonNulls.toList()
          : faliureActions.nonNulls.toList() + faliureAdditionalActions.nonNulls.toList();
  List<CAction> get actions => _resultActions + anyActions.nonNulls.toList() + anyAdditionalActions.nonNulls.toList();

  List<CReaction> get _resultReactions => result == CTransitionResults.notExecuted
      ? <CReaction>[]
      : result == CTransitionResults.success
          ? successReactions.nonNulls.toList()
          : faliureReactions.nonNulls.toList();
  List<CReaction> get reactions => _resultReactions + anyReactions.nonNulls.toList();

  List<CAction> get _resultCarryActions => result == CTransitionResults.notExecuted
      ? <CAction>[]
      : result == CTransitionResults.success
          ? successCarryActions.nonNulls.toList()
          : faliureCarryActions.nonNulls.toList();
  List<CAction> get carryActions => _resultCarryActions + anyCarryActions.nonNulls.toList();

  @override
  String toString() {
    return name;
  }
}
