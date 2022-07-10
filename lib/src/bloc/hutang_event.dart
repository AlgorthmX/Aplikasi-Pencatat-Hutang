part of 'hutang_bloc.dart';

@immutable
abstract class HutangEvent {}

class GetAllHutang extends HutangEvent {}

class AddHutang extends HutangEvent {
  final HutangEntity params;
  AddHutang({
    required this.params,
  });
}

class EditHutang extends HutangEvent {
  final HutangModel params;
  final bool useNotif;
  EditHutang({
    required this.params,
    this.useNotif = false,
  });
}

class DeleteHutang extends HutangEvent {
  final HutangModel params;
  final bool useNotif;
  DeleteHutang({
    required this.params,
    this.useNotif = false,
  });
}