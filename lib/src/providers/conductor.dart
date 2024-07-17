import 'package:conductor/conductor.dart';

// Based on the frequency of currentTimerProvider, we send a signal to the conductor
class ConductorNotifier extends Notifier {
  @override
  void build() {
    ref.watch(_conductorTimerProvider).value;
    CConductor.conduct(TimerIntervalCoreAction());
  }
}

final _conductorTimerProvider = StreamProvider<DateTime>((ref) {
  return Stream.periodic(const Duration(milliseconds: 500), (_) => DateTime.now());
});

final conductorTimeIntervalProvider = NotifierProvider<ConductorNotifier, void>(() {
  return ConductorNotifier();
});
