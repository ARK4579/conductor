import 'package:conductor/conductor.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class CoreRoute {
  final CoreUrl url;
  final IconData? icon;
  final bool showInNavRail;
  final Widget child;

  CoreRoute({
    required this.url,
    this.icon,
    this.showInNavRail = true,
    required this.child,
  });

  // If we want to do something to ALL screens, we can do it here
  // e.g. warapping all screens in NavigationRail
  Widget _builder(BuildContext context, GoRouterState state,
      List<CoreRoute> navRailRoutes) {
    final path = state.fullPath;

    List<CoreRoute> destinationRoutes = navRailRoutes
        .where((e) => e.icon != null && e.url.path != "/")
        .toList();
    List<NavigationRailDestination> destinations = destinationRoutes
        .map(
          (e) => NavigationRailDestination(
            icon: Icon(e.icon),
            label: Text(e.url.path),
          ),
        )
        .toList();
    final selectedIndex =
        destinationRoutes.indexWhere((e) => e.url.path == path);

    // mLog("destinationRoutes $destinationRoutes");
    // mLog("selectedIndex $selectedIndex");

    if (selectedIndex < 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No screen found for $path'),
            ],
          ),
        ],
      );
    }
    return destinations.length >= 2
        ? Row(
            children: [
              NavigationRail(
                destinations: destinations,
                selectedIndex: selectedIndex,
                onDestinationSelected: (int index) {
                  MyRouter.router.replace(destinationRoutes[index].url.path);
                },
              ),
              Expanded(child: child),
            ],
          )
        : child;
  }

  GoRoute toGoRoute(List<CoreRoute> navRailRoutes) {
    // mLog("toGoRoute ${url.path}; showInNavRail && icon != null: ${showInNavRail && icon != null}");
    return GoRoute(
      path: url.path,
      builder: (BuildContext context, GoRouterState state) =>
          showInNavRail && icon != null
              ? _builder(context, state, navRailRoutes)
              : child,
    );
  }
}

abstract class CoreRouter {
  GoRouter get router => GoRouter(
        routes: getGoRoutes,
        debugLogDiagnostics: kDebugMode,
      );

  List<GoRoute> get getGoRoutes =>
      routes.map((e) => e.toGoRoute(routes)).toList();

  List<CoreRoute> get routes => coreRoutes + appRoutes;

  // To be implemented by app routers
  List<CoreRoute> get appRoutes;

  Widget get homeScreen;

  List<CoreRoute> get coreRoutes => [
        CoreRoute(
          url: CoreUrls.home,
          icon: Icons.home,
          child: homeScreen,
          showInNavRail: false,
        ),
      ];
}
