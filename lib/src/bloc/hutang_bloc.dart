import 'package:bloc/bloc.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/data/repositories/hutang_repository.dart';
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
  }

  @override
  Future<void> close() {
    hutangRepository.close();
    return super.close();
  }
}
