import 'package:flutter/material.dart';

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
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 14),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: '회원 등급: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '테스트',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: '사용 중인 이용권: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '테스트',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: '생성한 사진 수: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '테스트',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: '남은 생성 횟수: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '테스트',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "최근 생성한 사진",
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.8
                            ),
                          ),
                          Text(
                            "갤러리로 이동하기",
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.8
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/images/splash_image1.webp",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              "assets/images/splash_image2.webp",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              "assets/images/splash_image3.webp",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              "assets/images/splash_image1.webp",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              "assets/images/splash_image2.webp",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
