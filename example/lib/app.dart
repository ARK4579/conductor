import 'example.dart';
import 'router.dart';

class ExampleApp extends AppBase {
  const ExampleApp({super.key});

  @override
  GoRouter get routerProvider => exampleRouterProvider;

  @override
  String get childAppName => 'Example Conductor App';

  @override
  int get minVerNo => 0;

  @override
  int get majVerNo => 0;

  @override
  int get revVerNo => 2;

  @override
  int get bldVerNo => 2;

  @override
  FutureWidgetRefCallBackFunction get providerInitializerFunction => (ref) async {};

  // @override
  // List<CGame> get games => [
  //       GeneralPOSGame(),
  //       ProductPOSGame(),
  //     ];
}
