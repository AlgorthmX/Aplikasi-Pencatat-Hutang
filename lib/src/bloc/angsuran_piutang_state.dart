part of 'angsuran_piutang_bloc.dart';

@immutable
abstract class AngsuranPiutangState {}

class AngsuranPiutangInitial extends AngsuranPiutangState {}

class AngsuranPiutangLoading extends AngsuranPiutangState {}

class AngsuranPiutangError extends AngsuranPiutangState {
  final String message;
  AngsuranPiutangError({
    required this.message,
  });
}

class AngsuranPiutangLoadSuccess extends AngsuranPiutangState {
  final List<AngsuranPiutangModel> allAngsuran;
  AngsuranPiutangLoadSuccess({
    required this.allAngsuran,
  });
}

class AngsuranPiutangNotifError extends AngsuranPiutangMessage {
  AngsuranPiutangNotifError({String? message}) : super(message: message ?? 'Notifikasi Error');
}

class AngsuranPiutangNotifSuccess extends AngsuranPiutangMessage {
  AngsuranPiutangNotifSuccess({
    String? message,
  }) : super(message: message ?? 'Notifikasi Berhasil');
}

class AngsuranPiutangMessage extends AngsuranPiutangState {
  final String message;
  AngsuranPiutangMessage({
    required this.message,
  });
}