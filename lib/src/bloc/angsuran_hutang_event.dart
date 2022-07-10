part of 'angsuran_hutang_bloc.dart';

@immutable
abstract class AngsuranHutangEvent {}

class GetAngsuranHutang extends AngsuranHutangEvent {
  final HutangModel hutang;
  GetAngsuranHutang({
    required this.hutang,
  });
}

class AddAngsuranHutang extends AngsuranHutangEvent {
  final AngsuranHutangEntity params;
  final HutangModel hutang;
  AddAngsuranHutang({
    required this.params,
    required this.hutang,
  });
}

class DeleteAngsuranHutang extends AngsuranHutangEvent {
  final AngsuranHutangModel params;
  final HutangModel hutang;
  DeleteAngsuranHutang({
    required this.params,
    required this.hutang,
  });
}
