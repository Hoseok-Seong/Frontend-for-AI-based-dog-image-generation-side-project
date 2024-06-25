import 'package:dio/dio.dart';
import 'package:puppicasso/interceptor/dio_interceptor.dart';
import 'package:puppicasso/models/picture_create_resp.dart';

class PictureCreateAPI {
  final Dio _dio = DioInterceptor.dio;

  Future<PictureCreateResp> fetchData() async {
    final response = await _dio.post(
        '/api/picture/create',
    );

    if (response.statusCode == 200) {
      return PictureCreateResp.fromJson(response.data);
    } else {
      throw Exception("Failed to load data");
    }
  }
}