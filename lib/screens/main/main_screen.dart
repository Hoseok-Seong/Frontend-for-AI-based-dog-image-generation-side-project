import 'package:flutter/material.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';

class MainScreen extends StatelessWidget {
  static String routeName = "/main";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        "Puppicasso는 반려견을 위한 다양한 컨셉의 AI 프로필 사진을 제공하는 서비스입니다",
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.8
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/picture_create");
                        },
                        child: Text("지금 바로 사진 생성하기"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          children: [
                            SizedBox(height: 14),
                            Text(
                              "회원 등급",
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "사용 중인 이용권",
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "생성한 사진 수",
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "남은 생성 횟수",
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8
                              ),
                            ),
                            SizedBox(height: 14),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
