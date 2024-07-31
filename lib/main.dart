import 'package:auth/presentation/pages/login_screen.dart';
import 'package:auth/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: MyRoutes.splashScreen,
      routes: {
        MyRoutes.splashScreen: (_) => const SplashScreen(),
        MyRoutes.loginScreen: (_) => const LoginScreen(),
      },
    );
  }
}
