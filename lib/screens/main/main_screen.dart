import 'package:flutter/material.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';

class MainScreen extends StatelessWidget {
  static String routeName = "/main";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Text(
                    "Puppicasso",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Puppicasso, 내 반려견만을 위한 AI 프로필",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 1),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/profile_create");
                    },
                    child: Text("프로필 사진 만들기"),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
    );
  }
}
