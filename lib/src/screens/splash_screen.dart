import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hutangin/src/bloc/auth_bloc.dart';
import 'package:hutangin/src/bloc/hutang_bloc.dart';
import 'package:hutangin/src/bloc/piutang_bloc.dart';
import 'package:hutangin/src/screens/pin_screen.dart';
import 'package:hutangin/src/util/auth_util.dart';

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
    await Future.delayed(const Duration(milliseconds: 1000));
    context.read<AuthBloc>().add(CheckIsAuthEnable());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthDisabled) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is AuthCheck) {
            if (state.authTypeEnabled == AuthType.pin) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const PinScreen(isAuth: true)));
            } else if (state.authTypeEnabled == AuthType.fingerprint) {
              Navigator.of(context).pushReplacementNamed("/authFingerprint");
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue.withOpacity(.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.receipt_long_rounded,
                size: 56,
              ),
              SizedBox(height: 24),
              Text(
                'HutangIn',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
