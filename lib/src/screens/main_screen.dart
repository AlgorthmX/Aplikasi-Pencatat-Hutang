import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:hutangin/src/screens/home_screen.dart';
import 'package:hutangin/src/screens/hutang_screen.dart';
import 'package:hutangin/src/screens/piutang_screen.dart';
import 'package:hutangin/src/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List _screens = const [
    HomeScreen(),
    PiutangScreen(),
    HutangScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: _screens[_currentIndex],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              textAlign: TextAlign.center,
              activeColor: Colors.blue,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              title: Text('Hutang'),
              textAlign: TextAlign.center,
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              title: Text('Piutang'),
              textAlign: TextAlign.center,
              activeColor: Colors.green,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              textAlign: TextAlign.center,
              activeColor: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
