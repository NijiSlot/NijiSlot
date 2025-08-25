import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rains/router/screen_controller.dart';
import 'package:rains/router/screen_name.dart';
import 'package:rains/ui/pages/splash/splash_view.dart';
import 'bindings/initial_binding.dart';

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
      theme: ThemeData(primarySwatch: Colors.red),
      getPages: AppScreens.screens,
      home: SplashPage(),
    );
  }
}
