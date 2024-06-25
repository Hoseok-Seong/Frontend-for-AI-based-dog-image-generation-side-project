import 'package:flutter/material.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  // 로그아웃 메서드: SharedPreferences에 저장된 JWT 삭제
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    // 로그인 화면으로 이동
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false,
    );
  }
}