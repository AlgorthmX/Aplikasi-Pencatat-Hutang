import 'package:bloc/bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/hutang_entity.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/data/repositories/hutang_repository.dart';
import 'package:hutangin/src/data/resources/mapper.dart';
import 'package:hutangin/src/data/resources/result.dart';
import 'package:meta/meta.dart';

part 'hutang_event.dart';
part 'hutang_state.dart';

class HutangBloc extends Bloc<HutangEvent, HutangState> {
  final HutangRepository hutangRepository;
  HutangBloc({
    required this.hutangRepository,
  }) : super(HutangInitial()) {
    on<GetAllHutang>((event, emit) async {
      emit(HutangLoading());
      Result<List<HutangModel>> allHutang =
          await hutangRepository.getAllHutang();
      if (allHutang is Success<List<HutangModel>>) {
        emit(HutangLoadSuccess(allHutang: allHutang.data));
      } else {
        String message = (allHutang as Error).message;
        emit(NotifError(message: message));
        emit(HutangError(message: message));
      }
    });

    on<AddHutang>((event, emit) async {
      List<HutangModel> allData = [];
      if (state is HutangLoadSuccess) {
        allData.addAll((state as HutangLoadSuccess).allHutang);
      }
      emit(HutangLoading());
      Result<HutangModel> insertHutang = await hutangRepository
          .insertHutang(mapHutangEntityToHutangModel(event.params));
      if (insertHutang is Success<HutangModel>) {
        allData.add(insertHutang.data);
        emit(NotifSuccess(message: "Berhasil menambahkan hutang"));
        emit(HutangLoadSuccess(allHutang: allData));
      } else {
        String message = (insertHutang as Error).message;
        emit(NotifError(message: message));
        emit(HutangLoadSuccess(allHutang: allData));
      }
    });

    on<EditHutang>((event, emit) async {
      List<HutangModel> allData = [];
      if (state is HutangLoadSuccess) {
        allData.addAll((state as HutangLoadSuccess).allHutang);
      }
      emit(HutangLoading());
      Result<HutangModel> editHutang =
          await hutangRepository.updateHutang(event.params);
      if (editHutang is Success<HutangModel>) {
        if (event.useNotif) {
          emit(NotifSuccess(message: "Berhasil mengubah hutang"));
        }
        emit(HutangLoadSuccess(
          allHutang: allData
              .map((hutang) =>
                  hutang.id == event.params.id ? editHutang.data : hutang)
              .toList(),
        ));
      } else {
        if (event.useNotif) {
          String message = (editHutang as Error).message;
          emit(NotifError(message: message));
        }
        emit(HutangLoadSuccess(allHutang: allData));
      }
    });

    on<DeleteHutang>((event, emit) async {
      List<HutangModel> allData = [];
      if (state is HutangLoadSuccess) {
        allData.addAll((state as HutangLoadSuccess).allHutang);
      }
      emit(HutangLoading());
      Result<bool> deleteHutang =
          await hutangRepository.deleteHutang(event.params);
      if (deleteHutang is Success<bool>) {
        if (event.useNotif) {
          emit(NotifSuccess(message: "Berhasil menghapus hutang"));
        }
        allData.removeWhere((hutang) => hutang.id == event.params.id);
        emit(HutangLoadSuccess(allHutang: allData));
      } else {
        if (event.useNotif) {
          String message = (deleteHutang as Error).message;
          emit(NotifError(message: message));
        }
        emit(HutangLoadSuccess(allHutang: allData));
      }
    });
  }

  @override
  Future<void> close() {
    hutangRepository.close();
    return super.close();
  }
}
