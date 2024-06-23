import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/models/user_join_req.dart';

class JoinAPI {
  final Dio _dio;

  JoinAPI() : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> join(UserJoinReq userJoinReq) async {
    try {
      final response = await _dio.post('/join', data: userJoinReq.toJson());

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("서버 오류: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("회원가입 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("알 수 없는 오류가 발생했습니다. 다시 시도해주세요.");
    }
  }
}