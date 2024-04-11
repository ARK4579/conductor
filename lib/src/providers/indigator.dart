import 'package:conductor/conductor.dart';

class IndigatorSignals {
  final Map<String, int> signals;

  IndigatorSignals(this.signals);
}

// Based on the frequency of currentTimerProvider, we update signals
class IndigatorNotifier extends Notifier<IndigatorSignals> {
  @override
  IndigatorSignals build() {
    Dataset.currentDateTime = ref.watch(currentTimerProvider).value;
    return IndigatorSignals(Dataset.signals);
  }
}

final indigatorProvider =
    NotifierProvider<IndigatorNotifier, IndigatorSignals>(() {
  return IndigatorNotifier();
});
