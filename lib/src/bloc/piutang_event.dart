part of 'piutang_bloc.dart';

@immutable
abstract class PiutangEvent {}

class GetAllPiutang extends PiutangEvent {}

class AddPiutang extends PiutangEvent {
  final PiutangEntity params;
  AddPiutang({
    required this.params,
  });
}

class EditPiutang extends PiutangEvent {
  final PiutangModel params;
  final bool useNotif;
  EditPiutang({
    required this.params,
    this.useNotif = false,
  });
}

class DeletePiutang extends PiutangEvent {
  final PiutangModel params;
  final bool useNotif;
  DeletePiutang({
    required this.params,
    this.useNotif = false,
  });
}
