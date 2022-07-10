part of 'angsuran_hutang_bloc.dart';

@immutable
abstract class AngsuranHutangState {}

class AngsuranHutangInitial extends AngsuranHutangState {}

class AngsuranHutangLoading extends AngsuranHutangState {}

class AngsuranHutangError extends AngsuranHutangState {
  final String message;
  AngsuranHutangError({
    required this.message,
  });
}

class AngsuranHutangLoadSuccess extends AngsuranHutangState {
  final List<AngsuranHutangModel> allAngsuran;
  AngsuranHutangLoadSuccess({
    required this.allAngsuran,
  });
}

class AngsuranHutangNotifError extends AngsuranHutangMessage {
  AngsuranHutangNotifError({String? message}) : super(message: message ?? 'Notifikasi Error');
}

class AngsuranHutangNotifSuccess extends AngsuranHutangMessage {
  AngsuranHutangNotifSuccess({
    String? message,
  }) : super(message: message ?? 'Notifikasi Berhasil');
}

class AngsuranHutangMessage extends AngsuranHutangState {
  final String message;
  AngsuranHutangMessage({
    required this.message,
  });
}