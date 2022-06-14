part of 'piutang_bloc.dart';

@immutable
abstract class PiutangEvent {}

class GetAllPiutang extends PiutangEvent {}

class AddPiutang extends PiutangEvent {}