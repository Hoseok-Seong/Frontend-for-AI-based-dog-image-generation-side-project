import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/models/user_login_req.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  final Dio _dio;

  LoginAPI() : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> login(UserLoginReq userLoginReq) async {
    try {
      final response = await _dio.post('/login', data: userLoginReq.toJson());

      if (response.statusCode == 200) {
        final accessToken = response.headers['Authorization_Access']?.first;
        final refreshToken = response.headers['Authorization_Refresh']?.first;

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
    } on DioException catch (e) {
      throw Exception("로그인 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("알 수 없는 오류가 발생했습니다. 다시 시도해주세요.");
    }
  }
}