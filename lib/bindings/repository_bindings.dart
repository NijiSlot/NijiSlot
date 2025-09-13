import 'package:rains/repositories/movie_repository.dart';
import 'package:rains/networks/api_client.dart';
import 'package:rains/networks/dio_client.dart';
import 'package:get/get.dart';

import '../repositories/notification_repository.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    final dio = DioClient.createDio();
    final apiClient = ApiClient(dio);

    Get.lazyPut<MovieRepository>(
      () => MovieRepositoryImpl(apiClient: apiClient),
      fenix: true,
    );
    Get.lazyPut<NotificationRepository>(
      () => NotificationRepositoryImpl(apiClient: apiClient),
      fenix: true,
    );
  }
}
