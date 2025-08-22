import 'package:flutter/material.dart';
import 'package:rains/router/screen_name.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(ScreensNames.getExample);
                    },
                    child: const Text("GET"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(ScreensNames.postExample);
                    },
                    child: const Text("POS"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
