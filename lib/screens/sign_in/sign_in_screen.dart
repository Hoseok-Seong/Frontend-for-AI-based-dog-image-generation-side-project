import 'package:flutter/material.dart';
import 'package:puppicasso/components/no_account_text.dart';
import 'package:puppicasso/components/circle_container.dart';
import 'package:puppicasso/screens/sign_in/components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 50,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 28),
                  const SignForm(),
                  const SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     CircleContainer(
                  //       icon: "assets/icons/google.svg",
                  //       press: () {},
                  //     ),
                  //     CircleContainer(
                  //       icon: "assets/icons/kakao.svg",
                  //       press: () {},
                  //     ),
                  //     CircleContainer(
                  //       icon: "assets/icons/naver.svg",
                  //       press: () {},
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  const NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
