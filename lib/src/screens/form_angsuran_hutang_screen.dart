import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hutangin/src/bloc/angsuran_hutang_bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/angsuran_hutang_entity.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/screens/widgets/custom_input.dart';
import 'package:intl/intl.dart';

class FormAngsuranHutangScreen extends StatefulWidget {
  final HutangModel hutang;
  const FormAngsuranHutangScreen({
    Key? key,
    required this.hutang,
  }) : super(key: key);

  @override
  _FormAngsuranHutangScreenState createState() =>
      _FormAngsuranHutangScreenState();
}

class _FormAngsuranHutangScreenState extends State<FormAngsuranHutangScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateInputController = TextEditingController();
  DateTime? _date;
  final format = DateFormat('yyyy-MM-dd');
  final _angsuranHutangEntity = AngsuranHutangEntity();
  FToast? _ftoast;

  @override
  void initState() {
    super.initState();
    _dateInputController.text = format.format(DateTime.now());
    _ftoast = FToast();
    _ftoast?.init(context);
    _date = DateTime.now();
    _angsuranHutangEntity.hutangId = widget.hutang.id;
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
            child: BlocListener<AngsuranHutangBloc, AngsuranHutangState>(
              listener: (context, state) {
                if (state is AngsuranHutangMessage) {
                  _ftoast?.showToast(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: state is AngsuranHutangNotifSuccess
                            ? Color.fromARGB(255, 197, 202, 200)
                            : Colors.redAccent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(state is AngsuranHutangNotifSuccess
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
                  if (state is AngsuranHutangNotifSuccess) {
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
                            "Form Angsuran Hutang",
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
                            _angsuranHutangEntity.nominal = int.parse(value!);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInput(
                          controller: _dateInputController,
                          label: "Tanggal Bayar",
                          isDate: true,
                          textInputType: TextInputType.datetime,
                          onSaved: (value) {
                            _angsuranHutangEntity.tanggalBayar = _date;
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
                            _angsuranHutangEntity.deskripsi = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInput(
                          label: "Cara Bayar (Opsional)",
                          textInputType: TextInputType.text,
                          isNullable: true,
                          onSaved: (value) {
                            _angsuranHutangEntity.caraBayar = value;
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
                                        .read<AngsuranHutangBloc>()
                                        .add(AddAngsuranHutang(
                                          params: _angsuranHutangEntity,
                                          hutang: widget.hutang,
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
