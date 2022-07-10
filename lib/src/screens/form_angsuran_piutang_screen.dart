import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hutangin/src/bloc/angsuran_piutang_bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/angsuran_piutang_entity.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';
import 'package:hutangin/src/screens/widgets/custom_input.dart';
import 'package:intl/intl.dart';

class FormAngsuranPiutangScreen extends StatefulWidget {
  final PiutangModel piutang;
  const FormAngsuranPiutangScreen({
    Key? key,
    required this.piutang,
  }) : super(key: key);

  @override
  _FormAngsuranPiutangScreenState createState() =>
      _FormAngsuranPiutangScreenState();
}

class _FormAngsuranPiutangScreenState extends State<FormAngsuranPiutangScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateInputController = TextEditingController();
  DateTime? _date;
  final format = DateFormat('yyyy-MM-dd');
  final _angsuranPiutangEntity = AngsuranPiutangEntity();
  FToast? _ftoast;

  @override
  void initState() {
    super.initState();
    _dateInputController.text = format.format(DateTime.now());
    _ftoast = FToast();
    _ftoast?.init(context);
    _date = DateTime.now();
    _angsuranPiutangEntity.piutangId = widget.piutang.id;
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
            child: BlocListener<AngsuranPiutangBloc, AngsuranPiutangState>(
              listener: (context, state) {
                if (state is AngsuranPiutangMessage) {
                  _ftoast?.showToast(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: state is AngsuranPiutangNotifSuccess
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(state is AngsuranPiutangNotifSuccess
                              ? Icons.check
                              : Icons.close),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(state.message),
                        ],
                      ),
                    ),
                  );
                  if (state is AngsuranPiutangNotifSuccess) {
                    Navigator.of(context).pop();
                  }
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
                            "Form Angsuran Piutang",
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
                          label: "Nominal",
                          textInputType: TextInputType.number,
                          onSaved: (value) {
                            _angsuranPiutangEntity.nominal = int.parse(value!);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInput(
                          controller: _dateInputController,
                          label: "Tanggal Bayar",
                          isDate: true,
                          textInputType: TextInputType.datetime,
                          onSaved: (value) {
                            _angsuranPiutangEntity.tanggalBayar = _date;
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
                          isNullable: true,
                          textInputType: TextInputType.text,
                          onSaved: (value) {
                            _angsuranPiutangEntity.deskripsi = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInput(
                          label: "Cara Bayar (Opsional)",
                          textInputType: TextInputType.text,
                          isNullable: true,
                          onSaved: (value) {
                            _angsuranPiutangEntity.caraBayar = value;
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
                                    context
                                        .read<AngsuranPiutangBloc>()
                                        .add(AddAngsuranPiutang(
                                          params: _angsuranPiutangEntity,
                                          piutang: widget.piutang,
                                        ));
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
