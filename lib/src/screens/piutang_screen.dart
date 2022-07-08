import 'package:flutter/material.dart';
import 'package:hutangin/src/screens/widgets/hutang_piutang_tile.dart';

class PiutangScreen extends StatelessWidget {
  const PiutangScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blueAccent.withOpacity(.2),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(.3),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    Icons.monetization_on_outlined,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: const Text(
                          "Piutang",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: Text(
                          'Rp 500.000',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 18, right: 18),
              children: [
                HutangPiutangTile(
                  tanggal: "10 Juni 2022",
                  nama: "Rahmad",
                  deskripsi: "Untuk membayar cicilan motor",
                  jumlah: 500000,
                  dibayar: 50000,
                  sisa: 450000,
                  onClick: () {

                  },
                ),
                HutangPiutangTile(
                  tanggal: "10 Juni 2022",
                  nama: "Rahmad",
                  deskripsi: "Untuk membayar cicilan motor",
                  jumlah: 500000,
                  dibayar: 50000,
                  sisa: 450000,
                  onClick: () {
                    
                  },
                ),
                HutangPiutangTile(
                  tanggal: "10 Juni 2022",
                  nama: "Rahmad",
                  deskripsi: "Untuk membayar cicilan motor",
                  jumlah: 500000,
                  dibayar: 50000,
                  sisa: 450000,
                  onClick: () {
                    
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}