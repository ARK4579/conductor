import 'package:conductor/conductor.dart';

//
// RouterCoreReaction
// RouterCoreReaction is a reaction that is used to route
//

abstract class RouterCoreReaction extends CReaction {
  GoRouter get _router => MyRouter.router;
}

class PopRouterCoreReaction extends RouterCoreReaction {
  @override
  void react() {
    if (_router.canPop()) {
      _router.pop();
    }
  }
}

class PushRouterCoreReaction extends RouterCoreReaction {
  final CoreUrl url;
  PushRouterCoreReaction({
    required this.url,
  });

  @override
  void react() {
    _router.push(url.path);
  }
}

class ReplaceRouterCoreReaction extends RouterCoreReaction {
  final CoreUrl url;
  ReplaceRouterCoreReaction({
    required this.url,
  });

  @override
  void react() {
    _router.replace(url.path);
  }
}
