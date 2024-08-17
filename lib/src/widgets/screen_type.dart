import 'package:conductor/conductor.dart';

class ScreenTypeWidget extends ConsumerWidget {
  final Widget mobileScreen;
  final Widget tabletScreen;
  final Widget desktopScreen;
  const ScreenTypeWidget({
    super.key,
    required this.mobileScreen,
    required this.tabletScreen,
    required this.desktopScreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScreenType? screenType = ref.watch(screenTypeProvider);

    if (screenType == null) {
      return const Center(child: Text("No Screentype."));
    }

    switch (screenType) {
      case ScreenType.mobile:
        return mobileScreen;
      case ScreenType.tablet:
        return tabletScreen;
      case ScreenType.desktop:
        return desktopScreen;
    }
  }
}
