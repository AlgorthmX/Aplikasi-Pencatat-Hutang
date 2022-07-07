import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hutangin/src/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({Key? key}) : super(key: key);

  @override
  _FingerprintScreenState createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  FToast? _ftoast;

  @override
  void initState() {
    super.initState();
    _ftoast = FToast();
    _ftoast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _ftoast?.showToast(
                child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.greenAccent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.close),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text("Autentikasi berhasil"),
                ],
              ),
            ));
            Navigator.of(context).pushReplacementNamed("/home");
          } else if (state is AuthError) {
            _ftoast?.showToast(
                child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.redAccent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.close),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(state.message),
                ],
              ),
            ));
          }
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: Image.asset(
                      "assets/images/undraw_fingerprint.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    "Autentikasi Biometrik",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Untuk melanjutkan ke aplikasi, harus melakukan autentikasi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(DoFingerprint());
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.centerRight,
                  onPrimary: Colors.transparent,
                  shadowColor: Colors.blue.withOpacity(.1),
                  surfaceTintColor: Colors.red,
                  primary: Colors.transparent,
                  elevation: 0,
                  onSurface: Colors.white,
                ),
                child: const Icon(
                  Icons.fingerprint,
                  size: 56,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
