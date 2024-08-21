import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/models/user_sign_in_req.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInAPI {
  final Dio _dio;

  SignInAPI() : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> signIn(UserSignInReq userSignInReq) async {
    try {
      final response = await _dio.post('/sign-in', data: userSignInReq.toJson());

      if (response.statusCode == 200) {
        // final accessToken = response.headers['Authorization_Access']?.first;
        // final refreshToken = response.headers['Authorization_Refresh']?.first;

        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];

        if (accessToken != null && refreshToken != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('refreshToken', refreshToken);
          return true;
        } else {
          throw Exception("토큰이 없습니다.");
        }
      } else {
        throw Exception("서버 오류: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("로그인 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
    }
  }
}