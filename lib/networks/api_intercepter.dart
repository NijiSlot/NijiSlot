import 'package:dio/dio.dart';
import 'package:rains/configs/app_configs.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TMDB v4 アクセストークンを Authorization ヘッダーに追加
    options.headers['Authorization'] = 'Bearer ${MovieAPIConfig.v4AccessToken}';
    options.headers['Accept'] = 'application/json'; // 必要な場合
    super.onRequest(options, handler);
  }
}
