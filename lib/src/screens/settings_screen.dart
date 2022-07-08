import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hutangin/src/bloc/auth_bloc.dart';
import 'package:hutangin/src/screens/pin_screen.dart';
import 'package:hutangin/src/screens/widgets/item_card.dart';
import 'package:hutangin/src/util/auth_util.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _arrow() {
    return Icon(
      Icons.arrow_forward_ios,
      size: 20.0,
    );
  }

  bool _isPinEnabled = false;
  bool _isFingerprintEnabled = false;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Settings',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: Container(
        color: (brightness == Brightness.light)
            ? Color(0xFFF7F7F7)
            : Color(0xFF000000),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: (brightness == Brightness.light)
                    ? Color(0xFFF7F7F7)
                    : Color(0xFF000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Privasi',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      if (state is AuthCheck) {
                        return Column(
                          children: [
                            ItemCard(
                              title: 'PIN Aplikasi',
                              color: (brightness == Brightness.light)
                                  ? Colors.white
                                  : Theme.of(context).scaffoldBackgroundColor,
                              rightWidget: Switch(
                                value: state.authTypeEnabled == AuthType.pin,
                                onChanged: (value) {
                                  setState(() {
                                    _isPinEnabled = value;
                                  });
                                  if (value) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => PinScreen(
                                                  isAuth: false,
                                                )));
                                  } else {
                                    context
                                        .read<AuthBloc>()
                                        .add(TogglePin(enable: false));
                                  }
                                },
                              ),
                            ),
                            state.isSupportFingerprint
                                ? ItemCard(
                                    title: 'Finggerprint',
                                    color: (brightness == Brightness.light)
                                        ? Colors.white
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor,
                                    rightWidget: Switch(
                                      value: state.authTypeEnabled ==
                                          AuthType.fingerprint,
                                      onChanged: (value) {
                                        setState(() {
                                          _isFingerprintEnabled = value;
                                        });
                                        context.read<AuthBloc>().add(
                                            ToggleFingerprint(enable: value));
                                      },
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        );
                      }
                      return const SizedBox();
                    }),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Tentang Aplikasi',
                        style: TextStyle(
                            fontFamily: 'NotoSansJP',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Kebijakan Privasi',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    ItemCard(
                      title: 'Berikan Rating',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    ItemCard(
                      title: 'Relase Notes',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Tentang Developer',
                        style: TextStyle(
                            fontFamily: 'NotoSansJP',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Version',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: Center(
                        child: Text('0.0.1',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
