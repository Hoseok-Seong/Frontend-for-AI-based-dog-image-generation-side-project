import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/models/user_sign_up_req.dart';

class SignUpAPI {
  final Dio dio;

  SignUpAPI() : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> signUp(UserSignUpReq userSignUpReq) async {
    try {
      final response = await dio.post('/sign-up', data: userSignUpReq.toJson());

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}