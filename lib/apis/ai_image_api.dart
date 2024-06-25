import 'package:dio/dio.dart';
import 'package:puppicasso/api_constants.dart';
import 'package:puppicasso/helper/logging_interceptor.dart';
import 'package:puppicasso/models/ai_image_req.dart';
import 'package:puppicasso/models/ai_image_resp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class AIImageAPI {
  final Dio _dio;

  AIImageAPI() : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<AIImageResp> generateAIImage(File image, AIImageReq aiImageReq) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
      'details': MultipartFile.fromString(
        jsonEncode(aiImageReq.toJson()),
        contentType: MediaType('application', 'json'),
      ),
    });

    final response = await _dio.post(
      '/api/ModelsLab/Images',
      data: formData,
      options: Options(
        headers: {
          'Authorization_Access': token,
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200) {
      return AIImageResp.fromJson(response.data);
    } else {
      throw Exception("Failed to generate AI image");
    }
  }
}