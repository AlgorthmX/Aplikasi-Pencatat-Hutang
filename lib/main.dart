import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hutangin/src/bloc/auth_bloc.dart';
import 'package:hutangin/src/bloc/hutang_bloc.dart';
import 'package:hutangin/src/bloc/piutang_bloc.dart';
import 'package:hutangin/src/data/datasource/local/local_data_source.dart';
import 'package:hutangin/src/data/repositories/auth_repository.dart';
import 'package:hutangin/src/data/repositories/hutang_repository.dart';
import 'package:hutangin/src/data/repositories/piutang_repository.dart';
import 'package:hutangin/src/screens/fingerprint_screen.dart';
import 'package:hutangin/src/screens/main_screen.dart';
import 'package:hutangin/src/screens/pin_screen.dart';
import 'package:hutangin/src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _localDataSource = LocalDataSource();
  final _hutangRepository = HutangRepository(_localDataSource);
  final _piutangRepository = PiutangRepository(_localDataSource);
  final _authRepository = AuthRepository(_localDataSource);
  runApp(MyApp(
    hutangRepository: _hutangRepository,
    piutangRepository: _piutangRepository,
    authRepository: _authRepository,
  ));
}

class MyApp extends StatelessWidget {
  final HutangRepository hutangRepository;
  final PiutangRepository piutangRepository;
  final AuthRepository authRepository;
  const MyApp({
    Key? key,
    required this.hutangRepository,
    required this.piutangRepository,
    required this.authRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HutangBloc>(
          create: (context) => HutangBloc(
            hutangRepository: hutangRepository,
          ),
        ),
        BlocProvider<PiutangBloc>(
          create: (context) => PiutangBloc(
            piutangRepository: piutangRepository,
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: authRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'HutangIn',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const MainScreen(),
          '/authPin': (context) => PinScreen(),
          '/authFingerprint': (context) => FingerprintScreen(),
        },
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
