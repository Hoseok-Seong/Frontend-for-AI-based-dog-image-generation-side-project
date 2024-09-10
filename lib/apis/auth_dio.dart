import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/models/new_access_token_req.dart';
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
      final userIdString = await storage.read(key: 'userId');
      final userId = int.tryParse(userIdString ?? '');
      final refreshToken = await storage.read(key: 'refreshToken');

      if (userId != null && refreshToken != null) {
        NewAccessTokenReq newAccessTokenReq = NewAccessTokenReq(userId: userId, refreshToken: refreshToken);

        var refreshDio = Dio(BaseOptions(baseUrl: baseUrl));

        try {
          final refreshResponse = await refreshDio.post(
            '/access-token',
            data: newAccessTokenReq.toJson(),
          );

          final newAccessToken = refreshResponse.data['accessToken'];
          final newRefreshToken = refreshResponse.data['refreshToken'];

          // 새 토큰 저장
          await storage.write(key: 'accessToken', value: newAccessToken);
          await storage.write(key: 'refreshToken', value: newRefreshToken);

          // 실패한 요청을 새 토큰으로 재시도
          error.requestOptions.headers['Authorization_Access'] = newAccessToken;

          final clonedRequest = await dio.request(
            error.requestOptions.path,
            options: Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            ),
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters,
          );

          return handler.resolve(clonedRequest); // 재시도 요청 해결
        } on DioException catch (e) {
          if (e.response?.data["code"] == 'JE03' || e.response?.data["code"] == 'C003') {
            await storage.deleteAll(); // 토큰 삭제
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          }
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    }
    return handler.next(error); // 처리되지 않은 오류 전달
  }));

  return dio;
}

// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:puppicasso/api_constants.dart';
// import 'package:puppicasso/models/new_access_token_req.dart';
// import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';
//
// Future<Dio> authDio(BuildContext context) async {
//   var dio = Dio(BaseOptions(baseUrl: baseUrl));
//
//   const storage = FlutterSecureStorage();
//
//   dio.interceptors.clear();
//
//   dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
//
//     final accessToken = await storage.read(key: 'accessToken');
//
//     options.headers['Authorization_Access'] = accessToken;
//     return handler.next(options);
//   }, onError: (error, handler) async {
//     if (error.response?.data["code"] == 'JE01' || error.response?.data["code"] == 'JE02') {
//       var refreshDio = Dio(BaseOptions(baseUrl: baseUrl));
//
//       refreshDio.interceptors.clear();
//
//       refreshDio.interceptors
//           .add(InterceptorsWrapper(onError: (error, handler) async {
//         final userId = await storage.read(key: 'userId');
//         final refreshToken = await storage.read(key: 'refreshToken');
//
//         NewAccessTokenReq newAccessTokenReq = NewAccessTokenReq(userId: userId, refreshToken: refreshToken);
//
//         final refreshResponse = await refreshDio.post('/access-token');
//
//         if (error.response?.data["code"] == 'JE03' || error.response?.data["code"] == 'C003') {
//           await storage.deleteAll();
//
//           Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
//         }
//         return handler.next(error);
//       }));
//
//       // refreshDio.options.headers['Authorization_Access'] = accessToken;
//       // refreshDio.options.headers['Authorization_Refresh'] = refreshToken;
//
//
//       final newAccessToken = refreshResponse.data['accessToken'];
//       final newRefreshToken = refreshResponse.data['refreshToken'];
//
//       await storage.write(key: 'accessToken', value: newAccessToken);
//       await storage.write(key: 'refreshToken', value: newRefreshToken);
//
//       error.requestOptions.headers['Authorization_Access'] = newAccessToken;
//
//       final clonedRequest = await dio.request(error.requestOptions.path,
//           options: Options(
//               method: error.requestOptions.method,
//               headers: error.requestOptions.headers),
//           data: error.requestOptions.data,
//           queryParameters: error.requestOptions.queryParameters);
//
//       return handler.resolve(clonedRequest);
//     }
//
//     return handler.next(error);
//   }));
//
//   return dio;
// }
