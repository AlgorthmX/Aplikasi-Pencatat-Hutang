import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hutangin/src/bloc/hutang_bloc.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/screens/angsuran_hutang_screen.dart';
import 'package:hutangin/src/screens/widgets/hutang_piutang_tile.dart';
import 'package:intl/intl.dart';

class HutangScreen extends StatelessWidget {
  HutangScreen({Key? key}) : super(key: key);

  final format = DateFormat('dd MMMM yyyy');
  final numberFormat = NumberFormat();

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
                    color: Colors.redAccent.withOpacity(.3),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    size: 48,
                    color: Colors.redAccent,
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
                          "Hutang",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: BlocBuilder<HutangBloc, HutangState>(
                          builder: (context, state) {
                            if (state is HutangLoadSuccess) {
                              int total = 0;
                              return Text(
                                'Rp ${numberFormat.format(total)}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          BlocConsumer<HutangBloc, HutangState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HutangLoadSuccess) {
                if (state.allHutang.isEmpty) {
                  return const Text(
                    "Hutang masih kosong!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    itemCount: state.allHutang.length,
                    itemBuilder: (context, i) {
                      HutangModel hutang = state.allHutang[i];
                      return HutangPiutangTile(
                        tanggal: format.format(hutang.tanggalPinjam),
                        nama: hutang.namaPemberiPinjaman,
                        deskripsi: hutang.deskripsi,
                        jumlah: hutang.nominal,
                        dibayar: hutang.sisa,
                        sisa: hutang.nominal - hutang.sisa,
                        onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AngsuranHutangScreen(hutang: hutang)));
                        },
                      );
                    },
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
