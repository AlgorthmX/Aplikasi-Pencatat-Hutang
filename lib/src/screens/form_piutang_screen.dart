import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hutangin/src/bloc/hutang_bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/piutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/screens/widgets/custom_input.dart';
import 'package:intl/intl.dart';

class FormPiutangScreen extends StatefulWidget {
  const FormPiutangScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FormPiutangScreenState createState() =>
      _FormPiutangScreenState();
}

class _FormPiutangScreenState extends State<FormPiutangScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateInputController = TextEditingController();
  DateTime? _date;
  final format = DateFormat('yyyy-MM-dd');
  final _piutangEntity = PiutangEntity();
  FToast? _ftoast;

  @override
  void initState() {
    super.initState();
    _dateInputController.text = format.format(DateTime.now());
    _ftoast = FToast();
    _ftoast?.init(context);
    _piutangEntity.status = StatusHutangPiutang.belumLunas;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          color: Colors.blueAccent.withOpacity(.2),
          child: Form(
            key: _formKey,
            child: BlocListener<HutangBloc, HutangState>(
              listener: (context, state) {
                if (state is HutangMessage) {
                  _ftoast?.showToast(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.greenAccent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(state.message),
                        ],
                      ),
                    ),
                  );
                }
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
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
                            "Form Piutang",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CustomInput(
                          label: "Nama Peminjam",
                          textInputType: TextInputType.text,
                          onSaved: (value) {
                            _piutangEntity.namaPeminjam = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInput(
                          label: "Nominal",
                          textInputType: TextInputType.number,
                          onSaved: (value) {
                            _piutangEntity.nominal = int.parse(value!);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInput(
                          controller: _dateInputController,
                          label: "Tanggal Pinjam",
                          isDate: true,
                          textInputType: TextInputType.datetime,
                          onSaved: (value) {
                            _piutangEntity.tanggalPinjam = _date;
                          },
                          onSuffixClick: () async {
                            _date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2023),
                            );
                            if (_date != null) {
                              _dateInputController.text = format.format(_date!);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInput(
                          label: "Deskripsi (Opsional)",
                          maxLines: 3,
                          textInputType: TextInputType.text,
                          isNullable: true,
                          onSaved: (value) {
                            _piutangEntity.deskripsi = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: const Text(
                                  "SIMPAN",
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // Add Hutang here
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
