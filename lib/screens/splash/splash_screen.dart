import 'package:flutter/material.dart';
import 'package:puppicasso/constants.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';
import 'package:puppicasso/screens/splash/components/splash_content.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "내 반려견만을 위한 AI 프로필",
      "image": "assets/images/splash_image1.webp"
    },
    {
      "text": "원하는 모든 맞춤형 프로필이 가능해요",
      "image": "assets/images/splash_image2.webp"
    },
    {
      "text": "반려견과의 추억을 간직해요",
      "image": "assets/images/splash_image3.webp"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                      itemCount: splashData.length,
                      itemBuilder: (context, index) => SplashContent(
                        image: splashData[index]["image"],
                        text: splashData[index]['text'],
                      ),
                  ),
              ),
              Expanded(
                  flex:2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                                (index) => AnimatedContainer(
                              duration: kAnimationDuration,
                              margin: const EdgeInsets.only(right: 5),
                              height: 6,
                              width: currentPage == index ? 20 : 6,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? kPrimaryColor
                                    : const Color(0xFFD8D8D8),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 3),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignInScreen.routeName);
                            },
                            child: const Text("계속하기"),
                        ),
                        const Spacer(flex: 5),
                      ],
                    )
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
