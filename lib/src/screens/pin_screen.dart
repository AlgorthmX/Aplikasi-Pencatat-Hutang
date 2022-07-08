import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hutangin/src/bloc/auth_bloc.dart';
import 'package:hutangin/src/util/auth_util.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinScreen extends StatefulWidget {
  final bool isAuth;
  const PinScreen({Key? key, this.isAuth = false}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  FToast? _ftoast;
  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();

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
          if (state is AuthEnabled) {
            if (state.authTypeEnabled == AuthType.pin) {
              _ftoast?.showToast(
                  child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.greenAccent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text("Autentikasi berhasil"),
                  ],
                ),
              ));
              Navigator.of(context).pushReplacementNamed("/home");
            }
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
          } else if (state is AuthToggleSuccess) {
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
                children: [
                  const Icon(Icons.check),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(state.message),
                ],
              ),
            ));
            Navigator.of(context).pop();
          }
        },
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 300,
                  child: Image.asset(
                    "assets/images/undraw_pin.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      widget.isAuth ? "Autentikasi PIN" : "Buat PIN",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.isAuth
                          ? "Untuk melanjutkan ke aplikasi, harus melakukan autentikasi"
                          : "Buat PIN untuk melakukan autentikasi sebelum melanjutkan ke aplikasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            inactiveFillColor: Colors.white,
                            activeFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            selectedColor: Colors.black54,
                            inactiveColor: Colors.black54,
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeColor: Colors.green,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          onCompleted: (pin) {
                            if (widget.isAuth) {
                              context.read<AuthBloc>().add(DoPin(pin: pin));
                            } else {
                              context
                                  .read<AuthBloc>()
                                  .add(TogglePin(enable: true, pin: pin));
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
