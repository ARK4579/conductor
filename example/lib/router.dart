import 'example.dart';

final exampleRouterProvider = ExampleRouter().router;

class ExampleRouter extends CoreRouter {
  @override
  Widget get homeScreen => const ExampleHomeScreen();

  @override
  List<CoreRoute> get appRoutes => [
        CoreRoute(
          url: ExampleUrls.home,
          icon: Icons.home,
          child: const ExampleHomeScreen(),
        ),
        // CoreRoute(
        //   url: ExampleUrls.contactQR,
        //   icon: Icons.contact_page,
        //   child: const ContactQRScreen(),
        // ),
        // CoreRoute(
        //   url: ExampleUrls.linkQR,
        //   icon: Icons.link,
        //   child: const TextQRScreen(),
        // ),
      ];
}
