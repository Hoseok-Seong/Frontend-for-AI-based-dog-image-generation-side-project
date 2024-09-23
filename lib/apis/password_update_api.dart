import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';

class PasswordUpdateAPI {
  final Dio dio;

  PasswordUpdateAPI() : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> passwordUpdate() async {
    try {
      return true;
    } on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}