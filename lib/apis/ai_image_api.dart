import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:puppicasso/apis/auth_dio.dart';
import 'package:puppicasso/models/ai_image_req.dart';
import 'package:puppicasso/models/ai_image_resp.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class AIImageAPI {
  Future<AIImageResp> generateAIImage(BuildContext context, File image, AIImageReq aiImageReq) async {
    try{
      var dio = await authDio(context);

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path),
        'details': MultipartFile.fromString(
          jsonEncode(aiImageReq.toJson()),
          contentType: MediaType('application', 'json'),
        ),
      });

      final response = await dio.post(
        '/api/models-lab/images',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.data['code'] == 'A001') {
        throw Exception("최대 이미지 사이즈인 10mb를 초과하였습니다.");
      }

      if (response.data['code'] == 'A002') {
        throw Exception("유효한 이미지 파일 형식이 아닙니다.");
      }

      if (response.data['code'] == 'S001') {
        throw Exception("유효기간이 만료되었거나, 가능한 사용 횟수를 초과한 구독권입니다.");
      }

      if (response.statusCode == 200) {
        return AIImageResp.fromJson(response.data);
      } else {
        throw Exception("Failed to generate AI image");
      }
    }on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}