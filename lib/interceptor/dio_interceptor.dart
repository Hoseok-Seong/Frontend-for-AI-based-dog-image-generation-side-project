import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/interceptor/auth_interceptor.dart';
import 'package:puppicasso/interceptor/logging_interceptor.dart';

class DioInterceptor {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(baseUrl: baseUrl));
      _dio!.interceptors.add(LoggingInterceptor());
      _dio!.interceptors.add(AuthInterceptor());
    }
    return _dio!;
  }
}