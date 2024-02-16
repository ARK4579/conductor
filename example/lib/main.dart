import 'example.dart';
import 'app.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(const ProviderScope(
    child: ExampleApp(),
  ));
}
