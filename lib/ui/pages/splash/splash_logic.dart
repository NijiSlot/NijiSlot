import 'package:rains/ui/pages/main/main_view.dart';

import 'package:get/get.dart';

class SplashLogic extends GetxController {
  void checkNetwork() async {
    await Future.delayed(Duration(seconds: 2));

    Get.offAll(MainPage());
  }
}
