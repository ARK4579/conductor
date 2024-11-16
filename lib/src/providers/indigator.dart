import 'package:conductor/conductor.dart';

class IndigatorSignals {
  final Map<String, Signal> signals;

  IndigatorSignals(this.signals);
}

// Based on the frequency of currentTimerProvider, we update signals
class IndigatorNotifier extends Notifier<IndigatorSignals> {
  @override
  IndigatorSignals build() {
    DatasetC().currentDateTime = ref.watch(currentTimerProvider).value;
    return IndigatorSignals(DatasetC().signals);
  }
}

final indigatorProvider = NotifierProvider<IndigatorNotifier, IndigatorSignals>(() {
  return IndigatorNotifier();
});
