part of 'angsuran_piutang_bloc.dart';

@immutable
abstract class AngsuranPiutangEvent {}

class GetAngsuranPiutang extends AngsuranPiutangEvent {
  final int piutangId;
  GetAngsuranPiutang({
    required this.piutangId,
  });
}

class AddAngsuranPiutang extends AngsuranPiutangEvent {
  final AngsuranPiutangEntity params;
  final PiutangModel piutang;
  AddAngsuranPiutang({
    required this.params,
    required this.piutang,
  });
}

class DeleteAngsuranPiutang extends AngsuranPiutangEvent {
  final AngsuranPiutangModel params;
  final PiutangModel piutang;
  DeleteAngsuranPiutang({
    required this.params,
    required this.piutang,
  });
}
