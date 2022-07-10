import 'package:bloc/bloc.dart';
import 'package:hutangin/src/bloc/hutang_bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/angsuran_hutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/hutang_entity.dart';
import 'package:hutangin/src/data/models/angsuran_hutang_model.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/data/repositories/hutang_repository.dart';
import 'package:hutangin/src/data/resources/mapper.dart';
import 'package:hutangin/src/data/resources/result.dart';
import 'package:meta/meta.dart';

part 'angsuran_hutang_event.dart';
part 'angsuran_hutang_state.dart';

class AngsuranHutangBloc
    extends Bloc<AngsuranHutangEvent, AngsuranHutangState> {
  final HutangRepository hutangRepository;
  final HutangBloc hutangBloc;
  AngsuranHutangBloc({
    required this.hutangRepository,
    required this.hutangBloc,
  }) : super(AngsuranHutangInitial()) {
    on<GetAngsuranHutang>((event, emit) async {
      emit(AngsuranHutangLoading());
      Result<List<AngsuranHutangModel>> allAngsuran =
          await hutangRepository.getAllAngsuranByHutangId(event.hutang.id);
      if (allAngsuran is Success<List<AngsuranHutangModel>>) {
        emit(AngsuranHutangLoadSuccess(allAngsuran: allAngsuran.data));
      } else {
        String message = (allAngsuran as Error).message;
        emit(AngsuranHutangNotifError(message: message));
        emit(AngsuranHutangError(message: message));
      }
    });

    on<AddAngsuranHutang>((event, emit) async {
      List<AngsuranHutangModel> allData = [];
      if (state is AngsuranHutangLoadSuccess) {
        allData.addAll((state as AngsuranHutangLoadSuccess).allAngsuran);
      }
      emit(AngsuranHutangLoading());
      Result<AngsuranHutangModel> resultInsert =
          await hutangRepository.insertAngsuranHutang(
              mapAngsuranHutangEntityToAngsuranHutangModel(event.params));
      if (resultInsert is Success<AngsuranHutangModel>) {
        allData.add(resultInsert.data);
        hutangBloc.add(EditHutang(
            useNotif: true,
            params: event.hutang.copyWith(
              dibayar: event.hutang.dibayar + event.params.nominal!,
            )));
        emit(AngsuranHutangNotifSuccess(
            message: "Berhasil menambahkan angsuran hutang"));
        emit(AngsuranHutangLoadSuccess(allAngsuran: allData));
      } else {
        String message = (resultInsert as Error).message;
        emit(AngsuranHutangNotifError(message: message));
        emit(AngsuranHutangLoadSuccess(allAngsuran: allData));
      }
    });

    on<DeleteAngsuranHutang>((event, emit) async {
      List<AngsuranHutangModel> allData = [];
      if (state is AngsuranHutangLoadSuccess) {
        allData.addAll((state as AngsuranHutangLoadSuccess).allAngsuran);
      }
      emit(AngsuranHutangLoading());
      Result<bool> resultDelete =
          await hutangRepository.deleteAngsuranHutang(event.params);
      if (resultDelete is Success<bool>) {
        allData.removeWhere((data) => data.id == event.params.id);
        hutangBloc.add(EditHutang(
            useNotif: true,
            params: event.hutang.copyWith(
              dibayar: event.hutang.nominal - event.params.nominal,
            )));
        emit(AngsuranHutangNotifSuccess(
            message: "Berhasil menghapus angsuran hutang"));
        emit(AngsuranHutangLoadSuccess(allAngsuran: allData));
      } else {
        String message = (resultDelete as Error).message;
        emit(AngsuranHutangNotifError(message: message));
        emit(AngsuranHutangLoadSuccess(allAngsuran: allData));
      }
    });
  }
}
