part of 'piutang_bloc.dart';

@immutable
abstract class PiutangState {}

class PiutangInitial extends PiutangState {}

class PiutangLoading extends PiutangState {}

class PiutangError extends PiutangState {
  final String message;
  PiutangError({
    required this.message,
  });
}

class PiutangLoadSuccess extends PiutangState {
  final List<PiutangModel> allPiutang;
  PiutangLoadSuccess({
    required this.allPiutang,
  });
}

class NotifError extends PiutangMessage {
  NotifError({String? message}) : super(message: message ?? 'Notifikasi Error');
}

class NotifSuccess extends PiutangMessage {
  NotifSuccess({
    String? message,
  }) : super(message: message ?? 'Notifikasi Berhasil');
}

class PiutangMessage extends PiutangState {
  final String message;
  PiutangMessage({
    required this.message,
  });
}
