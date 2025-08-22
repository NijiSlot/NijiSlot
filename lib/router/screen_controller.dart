import 'package:rains/router/screen_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:rains/ui/home/home_screen.dart';

abstract class AppScreens {
  static final screens = <GetPage>[
    GetPage(name: ScreensNames.home, page: () => const HomeScreen()),
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
