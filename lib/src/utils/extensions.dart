import 'package:conductor/conductor.dart';

extension ConductorWidgetRef on WidgetRef {
  void watchSignal(Signal singnal) => watch(indigatorProvider.select((invetigator) => invetigator.signals[singnal.name]));

  void watchSignalCurrentDateTime() => watchSignal(CurrentDateTimeSignal());
}
