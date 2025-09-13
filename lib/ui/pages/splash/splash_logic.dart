import 'package:rains/ui/pages/main/main_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rains/services/auth_service.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class SplashLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (!Get.isRegistered<AuthService>()) Get.put(AuthService());
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  void checkNetwork() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      final auth = Get.find<AuthService>();
      final tokens = await auth.getOrIssueTokens();
      print('getOrIssueTokens returned: $tokens');
      final uid = await auth.getUid();
      print('uid: $uid');
      final idToken = await _secureStorage.read(key: 'idToken');
      print('idToken: $idToken');
      final refreshToken = await _secureStorage.read(key: 'refreshToken');
      print('refreshToken: $refreshToken');
    } catch (e, st) {
      developer.log('Failed to read from secure storage: $e\n$st');
    }

    Get.offAll(MainPage());
  }
}
