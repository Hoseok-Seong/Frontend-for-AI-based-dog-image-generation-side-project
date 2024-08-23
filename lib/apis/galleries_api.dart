import 'package:dio/dio.dart';
import 'package:puppicasso/interceptor/dio_interceptor.dart';
import 'package:puppicasso/models/galleries_resp.dart';

class GalleriesAPI {
  late final Dio _dio;

  GalleriesAPI() {
    _dio = DioInterceptor.getDio();
  }

  Future<GalleriesResp> fetchData() async {
    final response = await _dio.get(
      '/api/gallery',
    );

    if (response.statusCode == 200) {
      return GalleriesResp.fromJson(response.data);
    } else {
      throw Exception("Failed to load data");
    }
  }
}