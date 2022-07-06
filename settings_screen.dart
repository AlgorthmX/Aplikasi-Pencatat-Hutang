import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hutangin/item_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  Widget _arrow() {
    return Icon(
      Icons.arrow_forward_ios,
      size: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: (brightness == Brightness.light) ? Color(0xFFF7F7F7) : Color(0xFF000000),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: (brightness == Brightness.light) ? Color(0xFFF7F7F7) : Color(0xFF000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Privasi',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Selesai Otomatis',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    ItemCard(
                      title: 'PIN Aplikasi',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    ItemCard(
                      title: 'Finggerprint',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Tentang Aplikasi',
                        style: TextStyle(fontFamily: 'NotoSansJP', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Kebijakan Privasi',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    ItemCard(
                      title: 'Berikan Rating',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    ItemCard(
                      title: 'Relase Notes',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Tentang Developer',
                        style: TextStyle(fontFamily: 'NotoSansJP', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF999999)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Berikan Masukan & Saran',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                    ),
                    ItemCard(
                      title: 'Log Out',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      textColor: Colors.red,
                    ),
                    ItemCard(
                      title: 'Version',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
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
