import 'package:flutter/material.dart';
import 'package:puppicasso/screens/main/main_screen.dart';
import 'package:puppicasso/screens/profile_create/profile_create_screen.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';

class ProfileDownloadScreen extends StatelessWidget {
  static String routeName = "/profile_download";

  const ProfileDownloadScreen({super.key});

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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: 250.0,
                height: 250.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/main_image.webp',
                    fit: BoxFit.cover,
                    width: 250.0,
                    height: 250.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileCreateScreen.routeName);
                },
                child: Text('프로필 사진 재생성하기'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileDownloadScreen.routeName);
                },
                child: Text('프로필 사진 다운로드하기'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
