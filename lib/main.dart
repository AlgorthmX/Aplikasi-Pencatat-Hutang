import 'package:flutter/material.dart';
import 'package:hutangin/src/data/datasource/local/local_data_source.dart';
import 'package:hutangin/src/data/repositories/hutang_repository.dart';
import 'package:hutangin/src/data/repositories/piutang_repository.dart';
import 'package:hutangin/src/screens/main_screen.dart';
import 'package:hutangin/src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _localDataSource = LocalDataSource();
  final _hutangRepository = HutangRepository(_localDataSource);
  final _piutangRepository = PiutangRepository(_localDataSource);
  runApp(MyApp(
    hutangRepository: _hutangRepository,
    piutangRepository: _piutangRepository,
  ));
}

class MyApp extends StatelessWidget {
  final HutangRepository hutangRepository;
  final PiutangRepository piutangRepository;
  const MyApp({
    Key? key,
    required this.hutangRepository,
    required this.piutangRepository,
  }) : super(key: key);

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
