import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  static String routeName = "/user_info";

  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(

              ),
            ]
          ),
        ),
      ),
    );
  }
}
