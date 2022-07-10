import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hutangin/src/bloc/angsuran_hutang_bloc.dart';
import 'package:hutangin/src/bloc/hutang_bloc.dart';
import 'package:hutangin/src/data/models/angsuran_hutang_model.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/screens/form_angsuran_hutang_screen.dart';
import 'package:hutangin/src/screens/widgets/angsuran_tile.dart';
import 'package:hutangin/src/screens/widgets/hutang_piutang_tile.dart';
import 'package:intl/intl.dart';

class AngsuranHutangScreen extends StatefulWidget {
  final HutangModel hutang;
  const AngsuranHutangScreen({
    Key? key,
    required this.hutang,
  }) : super(key: key);

  @override
  _AngsuranHutangScreenState createState() => _AngsuranHutangScreenState();
}

class _AngsuranHutangScreenState extends State<AngsuranHutangScreen> {
  final format = DateFormat('dd MMMM yyyy');
  final numberFormat = NumberFormat();
  bool _updated = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (contxet) => FormAngsuranHutangScreen(
                      hutang: widget.hutang,
                    )));
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
                            const Expanded(
                              child: Text(
                                "Detail Hutang",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Navigator.of(context).pop();
                                context
                                    .read<HutangBloc>()
                                    .add(DeleteHutang(params: widget.hutang));
                              },
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
                child: BlocConsumer<HutangBloc, HutangState>(
                  listener: (context, state) {
                    if (state is NotifSuccess) {
                      _updated = true;
                    }
                  },
                  builder: (context, state) {
                    if (_updated && state is HutangLoadSuccess) {
                      HutangModel hutang = state.allHutang.firstWhere(
                          (hutang) => hutang.id == widget.hutang.id);
                      return HutangPiutangTile(
                        tanggal: format.format(widget.hutang.tanggalPinjam),
                        nama: widget.hutang.namaPemberiPinjaman,
                        deskripsi: widget.hutang.deskripsi,
                        onClick: () {},
                        jumlah: hutang.nominal,
                        dibayar: hutang.dibayar,
                        sisa: hutang.nominal - hutang.dibayar,
                      );
                    }
                    return HutangPiutangTile(
                      tanggal: format.format(widget.hutang.tanggalPinjam),
                      nama: widget.hutang.namaPemberiPinjaman,
                      deskripsi: widget.hutang.deskripsi,
                      onClick: () {},
                      jumlah: widget.hutang.nominal,
                      dibayar: widget.hutang.dibayar,
                      sisa: widget.hutang.nominal - widget.hutang.dibayar,
                    );
                  },
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
              BlocBuilder<AngsuranHutangBloc, AngsuranHutangState>(
                builder: (context, state) {
                  if (state is AngsuranHutangLoadSuccess) {
                    if (state.allAngsuran.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: const Text(
                          "Angsuran masih kosong!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 22, right: 22, top: 18, bottom: 18),
                        itemCount: state.allAngsuran.length,
                        itemBuilder: (context, i) {
                          final AngsuranHutangModel angsuran =
                              state.allAngsuran[i];
                          return AngsuranTile(
                            tanggal: format.format(angsuran.tanggalBayar),
                            title: numberFormat.format(angsuran.nominal),
                            deskripsi: angsuran.deskripsi,
                            caraBayar: angsuran.caraBayar.isNotEmpty
                                ? angsuran.caraBayar
                                : null,
                            onDelete: () {
                              context
                                  .read<AngsuranHutangBloc>()
                                  .add(DeleteAngsuranHutang(
                                    params: angsuran,
                                    hutang: widget.hutang,
                                  ));
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
