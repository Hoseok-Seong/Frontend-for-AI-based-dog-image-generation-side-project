import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/models/user_sign_in_req.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInAPI {
  final Dio dio;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  SignInAPI() : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> signIn(UserSignInReq userSignInReq) async {
    try {
      final response = await dio.post('/sign-in', data: userSignInReq.toJson());

      if (response.statusCode == 200) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];

        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);

        return true;
      } else {
        throw Exception("로그인이 실패하였습니다");
      }
    } on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}