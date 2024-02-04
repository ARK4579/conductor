import 'package:conductor/conductor.dart';

enum ScreenType { mobile, desktop }

final Provider<ScreenType> screenTypeProvider = Provider((ref) {
  return ScreenType.desktop;
});
