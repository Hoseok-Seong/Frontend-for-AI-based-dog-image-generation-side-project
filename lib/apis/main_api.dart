import 'package:dio/dio.dart';
import 'package:puppicasso/interceptor/dio_interceptor.dart';
import 'package:puppicasso/models/main_resp.dart';

class MainAPI {
  late final Dio _dio;

  MainAPI() {
    _dio = DioInterceptor.getDio();
  }

  Future<MainResp> fetchData() async {
    try {
      final response = await _dio.get('/api/main');
      if (response.statusCode == 200) {
        return MainResp.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    } on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}