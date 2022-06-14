import 'package:bloc/bloc.dart';
import 'package:hutangin/src/data/datasource/database/entity/piutang_entity.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';
import 'package:hutangin/src/data/repositories/piutang_repository.dart';
import 'package:hutangin/src/data/resources/result.dart';
import 'package:meta/meta.dart';

part 'piutang_event.dart';
part 'piutang_state.dart';

class PiutangBloc extends Bloc<PiutangEvent, PiutangState> {
  final PiutangRepository piutangRepository;
  PiutangBloc({
    required this.piutangRepository,
  }) : super(PiutangInitial()) {
    on<PiutangEvent>((event, emit) async {
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
  }

  @override
  Future<void> close() {
    piutangRepository.close();
    return super.close();
  }
}
