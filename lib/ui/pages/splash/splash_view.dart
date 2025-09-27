import 'package:flutter/material.dart';
import 'package:rains/commons/app_images.dart';
import 'package:get/get.dart';

import 'splash_logic.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashLogic logic = Get.put(SplashLogic());

  @override
  void initState() {
    // TODO:
    super.initState();
    logic.checkNetwork();
    // ローカルストレージをリセットする関数
    // logic.performClearCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Image.asset(AppImages.icLogoTransparent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SplashLogic>();
    super.dispose();
  }
}
