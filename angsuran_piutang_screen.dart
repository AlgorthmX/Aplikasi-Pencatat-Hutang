import 'package:flutter/material.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';
import 'package:hutangin/src/screens/form_angsuran_piutang_screen.dart';
import 'package:hutangin/src/screens/widgets/angsuran_tile.dart';
import 'package:hutangin/src/screens/widgets/hutang_piutang_tile.dart';
import 'package:intl/intl.dart';

class AngsuranPiutangScreen extends StatefulWidget {
  final PiutangModel piutang;
  const AngsuranPiutangScreen({
    Key? key,
    required this.piutang,
  }) : super(key: key);

  @override
  _AngsuranPiutangScreenState createState() => _AngsuranPiutangScreenState();
}

class _AngsuranPiutangScreenState extends State<AngsuranPiutangScreen> {
  final format = DateFormat('dd MMMM yyyy');
  final numberFormat = NumberFormat();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (contxet) => const FormAngsuranPiutangScreen()));
          },
        ),
        body: Container(
          color: Colors.blueAccent.withOpacity(.2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Detail Piutang",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: HutangPiutangTile(
                  tanggal: format.format(widget.piutang.tanggalPinjam),
                  nama: widget.piutang.namaPeminjam,
                  deskripsi: widget.piutang.deskripsi,
                  onClick: () {},
                  jumlah: widget.piutang.nominal,
                  dibayar: widget.piutang.sisa,
                  sisa: widget.piutang.nominal - widget.piutang.sisa,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Angsuran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 22, right: 22, top: 18, bottom: 18),
                  itemCount: 2,
                  itemBuilder: (context, i) {
                    return AngsuranTile();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
