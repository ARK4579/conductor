import 'package:conductor/conductor.dart';

abstract class CoreFlags {
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktop => isLinux || isMacOS || isWindows;
  static bool get isWeb => isBrowser;

  // This should be asserted at the start of runtime to make sure one of these is true
  static bool get isAny => isMobile || isDesktop || isWeb;

  static List<String> get protectedValues => [""];
}
