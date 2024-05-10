import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static String routeName = "/error";

  const ErrorScreen({super.key});

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
