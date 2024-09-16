import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';

class ProfileUpdateAPI {
  final Dio dio;

  ProfileUpdateAPI() : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> profileUpdate() async {
    try {
      // final response = await dio.post('/password-update', data: userResetPasswordReq.toJson());

      // if (response.statusCode == 200) {
      //
      //   return true;
      // } else {
      //   throw Exception("'비밀번호 변경'이 실패하였습니다");
      // }
      return true;
    } on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}