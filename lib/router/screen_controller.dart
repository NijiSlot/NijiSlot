import 'package:rains/router/screen_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:rains/ui/pages/main/main_view.dart';
import 'package:rains/ui/pages/splash/splash_view.dart';

abstract class AppScreens {
  static final screens = <GetPage>[
    GetPage(name: ScreensNames.splash, page: () => SplashPage()),
    GetPage(name: ScreensNames.main, page: () => MainPage()),
    // GetPage(
    //   name: ScreensNames.getExample,
    //   page: () => const GetExampleScreen(),
    //   bindings: [GetExampleBinding()],
    // ),
    // GetPage(
    //   name: ScreensNames.postExample,
    //   page: () => const PostExampleScreen(),
    //   bindings: [PostExampleBinding()],
    // ),
  ];
}
