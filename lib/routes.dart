import 'package:flutter/widgets.dart';
import 'package:puppicasso/screens/forgot_password/forgot_password_screen.dart';
import 'package:puppicasso/screens/init_screen.dart';
import 'package:puppicasso/screens/main/main_screen.dart';
import 'package:puppicasso/screens/profile_create/profile_create_screen.dart';
import 'package:puppicasso/screens/profile_download/profile_download_screen.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';
import 'package:puppicasso/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:puppicasso/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  SignUpSuccessScreen.routeName: (context) => const SignUpSuccessScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  ProfileCreateScreen.routeName: (context) => const ProfileCreateScreen(),
  ProfileDownloadScreen.routeName: (context) => const ProfileDownloadScreen()
};