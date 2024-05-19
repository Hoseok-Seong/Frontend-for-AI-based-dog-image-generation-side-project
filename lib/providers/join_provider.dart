import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/models/user_join_req.dart';

final joinProvider = Provider((ref) => JoinService());

class JoinService {
  final Dio _dio = Dio();

  Future<bool> join(UserJoinReq userJoinReq) async {
    final String apiUrl = "http://192.168.200.103:8080/join";

    try {
      Response response = await _dio.post(apiUrl, data: userJoinReq.toJson());

      if (response.statusCode == 200) {
          print("회원가입 성공: ${response.data}");
          return true;
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