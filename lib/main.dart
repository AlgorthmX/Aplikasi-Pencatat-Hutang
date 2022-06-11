import 'package:flutter/material.dart';
import 'package:hutangin/src/screens/main_screen.dart';
import 'package:hutangin/src/screens/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HutangIn',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainScreen(),
      },
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

