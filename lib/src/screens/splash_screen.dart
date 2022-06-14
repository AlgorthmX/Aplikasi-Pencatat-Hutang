import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hutangin/src/bloc/hutang_bloc.dart';
import 'package:hutangin/src/bloc/piutang_bloc.dart';

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
    context.read<HutangBloc>().add(GetAllHutang());
    context.read<PiutangBloc>().add(GetAllPiutang());
    await Future.delayed(const Duration(milliseconds: 1500));
    await Future.microtask(
        () => {Navigator.of(context).pushReplacementNamed('/home')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue.withOpacity(.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.receipt_long_rounded,
              size: 48,
            ),
            SizedBox(height: 24),
            Text(
              'HutangIn',
            ),
          ],
        ),
      ),
    );
  }
}
