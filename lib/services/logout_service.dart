import 'package:flutter/material.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogoutService {
  Future<void> logout(BuildContext context) async {
    const storage = FlutterSecureStorage();

    await storage.deleteAll();

    // TODO: POP으로 해보기
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInScreen()), (
        route) => false);

    // Navigator.pop(
    //   context,
    //   MaterialPageRoute(builder: (context) => Navigator),
    // );
  }
}