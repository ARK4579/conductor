import 'package:conductor/conductor.dart';

class ViewPort {
  final Ref ref;
  final Map<String, int?> signals;

  const ViewPort({
    required this.ref,
    required this.signals,
  });
}
