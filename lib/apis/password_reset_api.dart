import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/models/user_sign_in_req.dart';

class PasswordResetAPI {
  final Dio dio;

  PasswordResetAPI() : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> passwordReset(UserSignInReq userSignInReq) async {
    try {
      final response = await dio.post('/password-reset', data: userSignInReq.toJson());

      if (response.statusCode == 200) {

        return true;
      } else {
        throw Exception("'비밀번호 찾기'가 실패하였습니다");
      }
    } on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}