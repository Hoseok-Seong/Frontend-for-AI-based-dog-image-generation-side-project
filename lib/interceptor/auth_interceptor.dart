import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {

  static const FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await storage.read(key: 'accessToken');

    if (token != null && options.path.contains('/api')) {
      options.headers['Authorization_Access'] = token;
    }

    return handler.next(options);
  }
}