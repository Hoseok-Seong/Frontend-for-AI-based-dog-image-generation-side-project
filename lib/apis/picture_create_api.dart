import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:puppicasso/apis/auth_dio.dart';
import 'package:puppicasso/models/picture_create_resp.dart';

class PictureCreateAPI {
  Future<PictureCreateResp> fetchData(BuildContext context) async {
    try {
      var dio = await authDio(context);
      final response = await dio.post('/api/picture-create',);

      if (response.statusCode == 200) {
        return PictureCreateResp.fromJson(response.data);
      } else {
        throw Exception("Failed to load data");
      }
    }on DioException catch (e) {
      throw Exception("네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    } catch (e) {
      throw Exception("내부 서버 오류가 발생했습니다.");
    }
  }
}