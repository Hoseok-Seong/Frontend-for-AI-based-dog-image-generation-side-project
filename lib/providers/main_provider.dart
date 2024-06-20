import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/models/main_req.dart';

final mainProvider = Provider((ref) => MainService());

class MainService {
  final Dio _dio = Dio();

  Future<bool> main(MainReq mainReq) async {
    final String apiUrl = "http://192.168.200.100:8080/api/main";

    try {
      Response response = await _dio.post(apiUrl, data: mainReq.toJson());

      if (response.statusCode == 200) {
        // 로그인 성공 처리
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