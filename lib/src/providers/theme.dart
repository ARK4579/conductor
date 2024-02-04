import 'package:conductor/conductor.dart';

// Config
const _themeScheme = FlexScheme.deepPurple;

// Providers
final Provider<ThemeData> themeProvider = Provider(
  (ref) => FlexThemeData.light(
    scheme: _themeScheme,
    useMaterial3: true,
  ),
);

final Provider<ThemeData> darkThemeProvider = Provider(
  (ref) => FlexThemeData.dark(
    scheme: _themeScheme,
    useMaterial3: true,
  ),
);
