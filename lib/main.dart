import 'package:flutter/material.dart';
import 'package:puppicasso/screens/init_screen.dart';
import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'routes.dart';
import 'theme.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'puppicasso',
      theme: AppTheme.lightTheme(context),
      // initialRoute: InitScreen.routeName,
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
}

