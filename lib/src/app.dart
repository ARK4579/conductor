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

  int get majVerNo;
  int get minVerNo;
  int get revVerNo;
  int get bldVerNo;

  String get versionBuildString => 'v$majVerNo.$minVerNo.$revVerNo+$bldVerNo';

  List<CGame> get games => [];

  Provider<ThemeData> get lightTP => themeProvider;
  Provider<ThemeData> get darkTP => darkThemeProvider;

  FutureWidgetRefCallBackFunction get providerInitializerFunction;

  const AppBase({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBaseState();
}

class _AppBaseState extends ConsumerState<AppBase> with AfterLayoutMixin<AppBase> {
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
    ref.watch(conductorTimeIntervalProvider);
    MyRouter.router = widget.routerProvider;

    mLog("AppBase++", print: CConductor.printLogsToConsole, file: CConductor.printLogsToFile);

    Future(() {
      final screenWidth = getScreenTypeFromSize(MediaQuery.of(context).size);
      ref.read(screenTypeProvider.notifier).update((state) => screenWidth);
    });

    return MaterialApp.router(
      title: '${widget.childAppName} ${widget.versionBuildString} ',
      theme: ref.watch(widget.lightTP),
      darkTheme: ref.watch(widget.darkTP),
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
