import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  _initApp() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    await Future.microtask(
        () => {Navigator.of(context).pushReplacementNamed('/home')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.monetization_on_outlined),
            const SizedBox(height: 24),
            Text(
              'HutangIn',
            ),
          ],
        ),
      ),
    );
  }
}
