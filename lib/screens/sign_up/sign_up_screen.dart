import 'package:flutter/material.dart';
import 'package:puppicasso/components/circle_container.dart';
import 'package:puppicasso/constants.dart';
import 'package:puppicasso/screens/sign_up/components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({super.key});

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
                  const SignUpForm(),
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
                  const SizedBox(height: 16),
                  Text(
                    'By continuing your confirm that you agree \nwith our Term and Condition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
