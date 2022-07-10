import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hutangin/src/bloc/angsuran_piutang_bloc.dart';
import 'package:hutangin/src/bloc/piutang_bloc.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';
import 'package:hutangin/src/screens/angsuran_piutang_screen.dart';
import 'package:hutangin/src/screens/widgets/hutang_piutang_tile.dart';
import 'package:intl/intl.dart';

class PiutangScreen extends StatelessWidget {
  PiutangScreen({Key? key}) : super(key: key);

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
                        child: BlocBuilder<PiutangBloc, PiutangState>(
                          builder: (context, state) {
                            int total = 0;
                            if (state is PiutangLoadSuccess) {
                              for (var piutang in state.allPiutang) {
                                total += (piutang.nominal - piutang.dibayar);
                              }
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
          BlocBuilder<PiutangBloc, PiutangState>(
            builder: (context, state) {
              if (state is PiutangLoadSuccess) {
                if (state.allPiutang.isEmpty) {
                  return const Text(
                    "Piutang masih kosong!",
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
                    itemCount: state.allPiutang.length,
                    itemBuilder: (context, i) {
                      PiutangModel piutang = state.allPiutang[i];
                      return HutangPiutangTile(
                        tanggal: format.format(piutang.tanggalPinjam),
                        nama: piutang.namaPeminjam,
                        deskripsi: piutang.deskripsi,
                        jumlah: piutang.nominal,
                        dibayar: piutang.dibayar,
                        sisa: piutang.nominal - piutang.dibayar,
                        onClick: () {
                          context
                              .read<AngsuranPiutangBloc>()
                              .add(GetAngsuranPiutang(piutangId: piutang.id));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AngsuranPiutangScreen(piutang: piutang)));
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
