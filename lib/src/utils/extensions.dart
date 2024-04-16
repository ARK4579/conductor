import 'package:conductor/conductor.dart';

extension ConductorWidgetRef on WidgetRef {
  void watchSignal(String singnalName) => watch(indigatorProvider.select((invetigator) => invetigator.signals[singnalName]));

  void watchSignalCurrentDateTime() => watchSignal(Dataset.signalCurrentDateTime);
}
