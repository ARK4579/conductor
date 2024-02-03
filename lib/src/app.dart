import 'package:conductor/conductor.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

abstract class AppBase extends ConsumerStatefulWidget {
  GoRouter get routerProvider;
  String get childAppName;
  String get versionBuildString;
  List<CGame> get games => [];

  FutureWidgetRefCallBackFunction get providerInitializerFunction;

  const AppBase({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBaseState();
}

class _AppBaseState extends ConsumerState<AppBase>
    with AfterLayoutMixin<AppBase> {
  @override
  void afterFirstLayout(BuildContext context) {
    for (CGame game in widget.games) {
      CConductor.addConductorGame(game);
    }
    Future(() {
      widget.providerInitializerFunction(ref).then((value) {
        ref.read(providerInitializingStatusP.notifier).update((state) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MyRouter.router = widget.routerProvider;

    mLog("AppBase++");

    return MaterialApp.router(
      title: '${widget.childAppName} ${widget.versionBuildString} ',
      theme: ref.watch(themeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: ThemeMode.system,
      routerDelegate: MyRouter.router.routerDelegate,
      routeInformationParser: MyRouter.router.routeInformationParser,
      routeInformationProvider: MyRouter.router.routeInformationProvider,
      supportedLocales: const [
        Locale('en', 'PK'),
        Locale('ur', 'PK'),
      ],
      localizationsDelegates: const [
        // FormBuilderLocalizations.delegate,
        // Delegates below take care of built-in flutter widgets
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // This delegate is required to provide the labels that are not overridden by LabelOverrides
        // FlutterFireUILocalizations.delegate,
      ],
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
    );
  }
}
