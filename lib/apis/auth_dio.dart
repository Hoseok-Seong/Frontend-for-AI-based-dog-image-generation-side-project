import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';

Future<Dio> authDio(BuildContext context) async {
  var dio = Dio(BaseOptions(baseUrl: baseUrl));

  const storage = FlutterSecureStorage();

  dio.interceptors.clear();

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {

    final accessToken = await storage.read(key: 'accessToken');

    options.headers['Authorization_Access'] = accessToken;
    return handler.next(options);
  }, onError: (error, handler) async {

    if (error.response?.data["code"] == 'JE01' || error.response?.data["code"] == 'JE02') {

      final accessToken = await storage.read(key: 'accessToken');
      final refreshToken = await storage.read(key: 'refreshToken');

      var refreshDio = Dio();

      refreshDio.interceptors.clear();

      refreshDio.interceptors
          .add(InterceptorsWrapper(onError: (error, handler) async {

        if (error.response?.data["code"] == 'JE03' || error.response?.data["code"] == 'C003') {
          await storage.deleteAll();

          Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
        }
        return handler.next(error);
      }));

      refreshDio.options.headers['Authorization_Access'] = accessToken;
      refreshDio.options.headers['Authorization_Refresh'] = refreshToken;

      final refreshResponse = await refreshDio.post('/access-token');

      final newAccessToken = refreshResponse.data['accessToken'];
      final newRefreshToken = refreshResponse.data['refreshToken'];

      await storage.write(key: 'accessToken', value: newAccessToken);
      await storage.write(key: 'refreshToken', value: newRefreshToken);

      error.requestOptions.headers['Authorization_Access'] = newAccessToken;

      final clonedRequest = await dio.request(error.requestOptions.path,
          options: Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers),
          data: error.requestOptions.data,
          queryParameters: error.requestOptions.queryParameters);

      return handler.resolve(clonedRequest);
    }

    return handler.next(error);
  }));

  return dio;
}