import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _dashboardTile(
    BuildContext context, {
    required Widget icon,
    required Color? iconBgColor,
    required String title,
    required String description,
    required String nominal,
  }) {
    final widthTile = MediaQuery.of(context).size.width * .52 - (24 * 2);
    return Container(
      width: widthTile,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: iconBgColor,
                    ),
                    child: icon,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: widthTile * .1,
                      color: Color(0xFF112138),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            nominal,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF112138),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.1),
      ),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Hai Riski, Selamat Pagi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _dashboardTile(
                context,
                iconBgColor: Colors.red[100],
                icon: Icon(
                  Icons.receipt_long_rounded,
                  size: 36,
                  color: Colors.red[300],
                ),
                title: 'Hutang',
                description: 'Uang yang dipinjam dari orang lain',
                nominal: 'Rp 1.000.000',
              ),
              _dashboardTile(
                context,
                iconBgColor: Colors.green[100],
                icon: Icon(
                  Icons.monetization_on_outlined,
                  size: 36,
                  color: Colors.green[300],
                ),
                title: 'Piutang',
                description:
                    'Uang yang dipinjamkan (yang dapat ditagih dari seseorang)',
                nominal: 'Rp 1.000.000',
              )
            ],
          ),
        ],
      ),
    );
  }
}
