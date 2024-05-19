import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/models/user_login_req.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider = Provider((ref) => LoginService());

class LoginService {
  final Dio _dio = Dio();

  Future<bool> login(UserLoginReq userLoginReq) async {
    final String apiUrl = "http://192.168.200.103:8080/login";

    try {
      Response response = await _dio.post(apiUrl, data: userLoginReq.toJson());

      if (response.statusCode == 200) {
        // 로그인 성공 처리
        final accessToken = response.headers['Authorization_Access']?.first;
        final refreshToken = response.headers['Authorization_Refresh']?.first;

        // 토큰 저장
        if (accessToken != null && refreshToken != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('refreshToken', refreshToken);
          print("로그인 성공: ${response.data}");
          print(prefs.getString('accessToken'));
          print(prefs.getString('refreshToken'));
          return true;
        } else {
          print("로그인 실패: ${response.data}");
          print("토큰이 없습니다.");
          return false;
        }
      } else {
        // 서버 오류 처리
        print("서버 오류: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      // Dio 오류 처리 (요청 실패, 타임아웃 등)
      print("Dio 오류: ${e.message}");
      return false;
    }
  }
}