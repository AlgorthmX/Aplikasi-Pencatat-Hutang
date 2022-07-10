import 'package:bloc/bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/piutang_entity.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';
import 'package:hutangin/src/data/repositories/piutang_repository.dart';
import 'package:hutangin/src/data/resources/mapper.dart';
import 'package:hutangin/src/data/resources/result.dart';
import 'package:meta/meta.dart';

part 'piutang_event.dart';
part 'piutang_state.dart';

class PiutangBloc extends Bloc<PiutangEvent, PiutangState> {
  final PiutangRepository piutangRepository;
  PiutangBloc({
    required this.piutangRepository,
  }) : super(PiutangInitial()) {
    on<GetAllPiutang>((event, emit) async {
      emit(PiutangLoading());
      Result<List<PiutangModel>> allPiutang =
          await piutangRepository.getAllPiutang();
      if (allPiutang is Success<List<PiutangModel>>) {
        emit(PiutangLoadSuccess(allPiutang: allPiutang.data));
      } else {
        String message = (allPiutang as Error).message;
        emit(NotifError(message: message));
        emit(PiutangError(message: message));
      }
    });

    on<AddPiutang>((event, emit) async {
      List<PiutangModel> allData = [];
      if (state is PiutangLoadSuccess) {
        allData.addAll((state as PiutangLoadSuccess).allPiutang);
      }
      emit(PiutangLoading());
      Result<PiutangModel> insertPiutang = await piutangRepository
          .insertPiutang(mapPiutangEntityToPiutangModel(event.params));
      if (insertPiutang is Success<PiutangModel>) {
        allData.add(insertPiutang.data);
        emit(NotifSuccess(message: "Berhasil menambahkan piutang"));
        emit(PiutangLoadSuccess(allPiutang: allData));
      } else {
        String message = (insertPiutang as Error).message;
        emit(NotifError(message: message));
        emit(PiutangLoadSuccess(allPiutang: allData));
      }
    });

    on<EditPiutang>((event, emit) async {
      List<PiutangModel> allData = [];
      if (state is PiutangLoadSuccess) {
        allData.addAll((state as PiutangLoadSuccess).allPiutang);
      }
      emit(PiutangLoading());
      Result<PiutangModel> editPiutang =
          await piutangRepository.updatePiutang(event.params);
      if (editPiutang is Success<PiutangModel>) {
        if (event.useNotif) {
          emit(NotifSuccess(message: "Berhasil mengubah piutang"));
        }
        emit(PiutangLoadSuccess(
          allPiutang: allData
              .map((piutang) =>
                  piutang.id == event.params.id ? editPiutang.data : piutang)
              .toList(),
        ));
      } else {
        if (event.useNotif) {
          String message = (editPiutang as Error).message;
          emit(NotifError(message: message));
        }
        emit(PiutangLoadSuccess(allPiutang: allData));
      }
    });

    on<DeletePiutang>((event, emit) async {
      List<PiutangModel> allData = [];
      if (state is PiutangLoadSuccess) {
        allData.addAll((state as PiutangLoadSuccess).allPiutang);
      }
      emit(PiutangLoading());
      Result<bool> deletePiutang =
          await piutangRepository.deletePiutang(event.params);
      if (deletePiutang is Success<bool>) {
        if (event.useNotif) {
          emit(NotifSuccess(message: "Berhasil menghapus piutang"));
        }
        allData.removeWhere((piutang) => piutang.id == event.params.id);
        emit(PiutangLoadSuccess(allPiutang: allData));
      } else {
        if (event.useNotif) {
          String message = (deletePiutang as Error).message;
          emit(NotifError(message: message));
        }
        emit(PiutangLoadSuccess(allPiutang: allData));
      }
    });
  }

  @override
  Future<void> close() {
    piutangRepository.close();
    return super.close();
  }
}
