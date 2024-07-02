import 'package:conductor/conductor.dart';

extension ConductorWidgetRef on WidgetRef {
  void watchSignal(Signal? _singnal) =>
      _singnal != null ? watch(indigatorProvider.select((invetigator) => invetigator.signals[_singnal.name])) : null;

  void watchSignalCurrentDateTime() => watchSignal(CurrentDateTimeSignal());
}
