import 'package:flutter/material.dart';
import 'package:hutangin/src/screens/widgets/chip_widget.dart';

class HutangPiutangTile extends StatelessWidget {
  final String tanggal;
  final String nama;
  final String deskripsi;
  final VoidCallback onClick;
  final int jumlah;
  final int dibayar;
  final int sisa;
  const HutangPiutangTile({
    Key? key,
    required this.tanggal,
    required this.nama,
    required this.deskripsi,
    required this.onClick,
    required this.jumlah,
    required this.dibayar,
    required this.sisa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                tanggal,
                style: TextStyle(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(.45),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ChipWidget(
                  title: "Jumlah",
                  subtitle: "Rp $jumlah",
                  color: Colors.grey,
                  onClick: () {},
                ),
                const SizedBox(width: 8),
                ChipWidget(
                  title: "Dibayar",
                  subtitle: "Rp $dibayar",
                  color: Colors.greenAccent,
                  onClick: () {},
                ),
                const SizedBox(width: 8),
                ChipWidget(
                  title: "Sisa",
                  subtitle: "Rp $sisa",
                  color: Colors.redAccent,
                  onClick: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
