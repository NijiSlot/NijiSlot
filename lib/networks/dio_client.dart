import 'package:dio/dio.dart';
import 'api_intercepter.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio();
    dio.interceptors.add(ApiInterceptor());
    return dio;
  }
}
