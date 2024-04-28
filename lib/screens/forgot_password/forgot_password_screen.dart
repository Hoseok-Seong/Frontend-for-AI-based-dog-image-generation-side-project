import 'package:flutter/material.dart';
import 'package:puppicasso/screens/forgot_password/components/forgot_password_form.dart';


class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("비밀번호 찾기"),
      ),
      body: const SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  "비밀번호 찾기",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "비밀번호를 재설정할 수 있는 링크를 보내줘요",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                ForgotPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}