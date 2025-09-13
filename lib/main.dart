import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rains/router/screen_controller.dart';
import 'package:rains/router/screen_name.dart';
import 'package:rains/ui/pages/splash/splash_view.dart';
import 'bindings/initial_binding.dart';
import 'package:rains/commons/app_colors.dart';

void main() {
  for (var page in AppScreens.screens) {
    Get.put(page, tag: page.name);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: 'rains',
      theme: ThemeData(
        primarySwatch: Colors.red,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.bottomNavigationBar,
          selectedItemColor: AppColors.selectedColor,
          unselectedItemColor: AppColors.unselectedColor,

          selectedIconTheme: IconThemeData(size: 28),
          unselectedIconTheme: IconThemeData(size: 28),
          selectedLabelStyle: TextStyle(
            fontSize: 9, // 選択時文字サイズ
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 9, // 非選択時文字サイズ
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      getPages: AppScreens.screens,
      home: SplashPage(),
    );
  }
}
