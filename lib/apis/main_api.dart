import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/helper/logging_interceptor.dart';
import 'package:puppicasso/models/main_resp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAPI {
  final Dio _dio;

  MainAPI() : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<MainResp> fetchMainData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final response = await _dio.get(
        '/api/main',
        options: Options(headers: {'Authorization_Access': token})
    );

    if (response.statusCode == 200) {
      return MainResp.fromJson(response.data);
    } else {
      throw Exception("Failed to load data");
    }
  }
}