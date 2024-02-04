import 'package:conductor/conductor.dart';

class ViewPortNotifier extends Notifier<ViewPort> {
  DateTime? _currentDateTime;

  void setSignal(String signalName, {int? signalValue}) {
    state.signals.update(signalName, (value) {
      return signalValue ?? _currentDateTime?.millisecondsSinceEpoch;
    });
  }

  @override
  ViewPort build() {
    _currentDateTime = ref.watch(currentTimerProvider).value;
    return ViewPort(
      ref: ref,
      signals: Dataset.signals,
    );
  }
}

final viewPortProvider = NotifierProvider<ViewPortNotifier, ViewPort>(() {
  return ViewPortNotifier();
});
