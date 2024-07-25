import 'package:conductor/conductor.dart';

enum ScreenType {
  mobile,
  tablet,
  desktop,
}

final screenTypeProvider = StateProvider<ScreenType?>((ref) => null);

ScreenType getScreenTypeFromSize(Size size) {
  if (size.width < 600) {
    return ScreenType.mobile;
  } else if (size.width < 1200) {
    return ScreenType.tablet;
  } else {
    return ScreenType.desktop;
  }
}
