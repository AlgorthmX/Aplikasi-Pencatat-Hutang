part of 'hutang_bloc.dart';

@immutable
abstract class HutangState {}

class HutangInitial extends HutangState {}

class HutangLoading extends HutangState {}

class HutangError extends HutangState {
  final String message;
  HutangError({
    required this.message,
  });
}

class HutangLoadSuccess extends HutangState {
  final List<HutangModel> allHutang;
  HutangLoadSuccess({
    required this.allHutang,
  });
}

class NotifError extends HutangMessage {
  NotifError({String? message}) : super(message: message ?? 'Notifikasi Error');
}

class NotifSuccess extends HutangMessage {
  NotifSuccess({
    String? message,
  }) : super(message: message ?? 'Notifikasi Berhasil');
}

class HutangMessage extends HutangState {
  final String message;
  HutangMessage({
    required this.message,
  });
}
