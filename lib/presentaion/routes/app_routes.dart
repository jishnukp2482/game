import 'package:game/presentaion/pages/home_page.dart';
import 'package:game/presentaion/pages/splash_screen.dart';
import 'package:game/presentaion/routes/app_pages.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
    static GoRouter router = GoRouter(
      initialLocation: AppPages.splashpage,
      routes: [
    GoRoute(path: AppPages.splashpage,
    builder: (context, state) => SplashScreen(),
    ),
     GoRoute(
      path: AppPages.homepage,
      builder: (context, state) => HomePage(),
    ),
  ]);
}
