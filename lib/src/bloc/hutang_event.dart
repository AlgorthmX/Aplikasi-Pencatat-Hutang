part of 'hutang_bloc.dart';

@immutable
abstract class HutangEvent {}

class GetAllHutang extends HutangEvent {}

class AddHutang extends HutangEvent {}
