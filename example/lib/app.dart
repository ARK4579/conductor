import 'example.dart';
import 'router.dart';

class ExampleApp extends AppBase {
  const ExampleApp({super.key});

  @override
  GoRouter get routerProvider => exampleRouterProvider;

  @override
  String get childAppName => 'Example Conductor App';

  @override
  String get versionBuildString => 'v0.0.1';

  @override
  FutureWidgetRefCallBackFunction get providerInitializerFunction =>
      (ref) async {};

  // @override
  // List<CGame> get games => [
  //       GeneralPOSGame(),
  //       ProductPOSGame(),
  //     ];
}
