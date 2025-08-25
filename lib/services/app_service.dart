import 'package:rains/model/entities/index.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  // Theme
  final Rx<UserEntity?> user = null.obs;

  Future<AppService> init() async {
    return this;
  }
}
