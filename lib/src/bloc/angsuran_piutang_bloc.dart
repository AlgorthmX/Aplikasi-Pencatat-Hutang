import 'package:bloc/bloc.dart';
import 'package:hutangin/src/bloc/piutang_bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/angsuran_piutang_entity.dart';
import 'package:hutangin/src/data/models/angsuran_piutang_model.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';
import 'package:hutangin/src/data/repositories/piutang_repository.dart';
import 'package:hutangin/src/data/resources/mapper.dart';
import 'package:hutangin/src/data/resources/result.dart';
import 'package:meta/meta.dart';

part 'angsuran_piutang_event.dart';
part 'angsuran_piutang_state.dart';

class AngsuranPiutangBloc
    extends Bloc<AngsuranPiutangEvent, AngsuranPiutangState> {
  final PiutangRepository piutangRepository;
  final PiutangBloc piutangBloc;
  AngsuranPiutangBloc({
    required this.piutangRepository,
    required this.piutangBloc,
  }) : super(AngsuranPiutangInitial()) {
    on<GetAngsuranPiutang>((event, emit) async {
      emit(AngsuranPiutangLoading());
      Result<List<AngsuranPiutangModel>> allAngsuran =
          await piutangRepository.getAllAngsuranByPiutangId(event.piutangId);
      if (allAngsuran is Success<List<AngsuranPiutangModel>>) {
        emit(AngsuranPiutangLoadSuccess(allAngsuran: allAngsuran.data));
      } else {
        String message = (allAngsuran as Error).message;
        emit(AngsuranPiutangNotifError(message: message));
        emit(AngsuranPiutangError(message: message));
      }
    });

    on<AddAngsuranPiutang>((event, emit) async {
      List<AngsuranPiutangModel> allData = [];
      if (state is AngsuranPiutangLoadSuccess) {
        allData.addAll((state as AngsuranPiutangLoadSuccess).allAngsuran);
      }
      emit(AngsuranPiutangLoading());
      Result<AngsuranPiutangModel> resultInsert =
          await piutangRepository.insertAngsuranPiutang(
              mapAngsuranPiutangEntityToAngsuranPiutangModel(event.params));
      if (resultInsert is Success<AngsuranPiutangModel>) {
        allData.add(resultInsert.data);
        piutangBloc.add(EditPiutang(
            useNotif: true,
            params: event.piutang.copyWith(
              dibayar: event.piutang.dibayar + event.params.nominal!,
            )));
        emit(AngsuranPiutangNotifSuccess(
            message: "Berhasil menambahkan angsuran piutang"));
        emit(AngsuranPiutangLoadSuccess(allAngsuran: allData));
      } else {
        String message = (resultInsert as Error).message;
        emit(AngsuranPiutangNotifError(message: message));
        emit(AngsuranPiutangLoadSuccess(allAngsuran: allData));
      }
    });

    on<DeleteAngsuranPiutang>((event, emit) async {
      List<AngsuranPiutangModel> allData = [];
      if (state is AngsuranPiutangLoadSuccess) {
        allData.addAll((state as AngsuranPiutangLoadSuccess).allAngsuran);
      }
      emit(AngsuranPiutangLoading());
      Result<bool> resultDelete =
          await piutangRepository.deleteAngsuranPiutang(event.params);
      if (resultDelete is Success<bool>) {
        allData.removeWhere((data) => data.id == event.params.id);
        piutangBloc.add(EditPiutang(
            useNotif: true,
            params: event.piutang.copyWith(
              dibayar: event.piutang.nominal - event.params.nominal,
            )));
        emit(AngsuranPiutangNotifSuccess(
            message: "Berhasil menghapus angsuran piutang"));
        emit(AngsuranPiutangLoadSuccess(allAngsuran: allData));
      } else {
        String message = (resultDelete as Error).message;
        emit(AngsuranPiutangNotifError(message: message));
        emit(AngsuranPiutangLoadSuccess(allAngsuran: allData));
      }
    });
  }
}
