import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/data/datasource/local/local_data_source.dart';
import 'package:hutangin/src/data/models/angsuran_piutang_model.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';
import 'package:hutangin/src/data/resources/error_handler.dart';
import 'package:hutangin/src/data/resources/mapper.dart';
import 'package:hutangin/src/data/resources/result.dart';

class PiutangRepository {
  final LocalDataSource _localDataSource;

  PiutangRepository(this._localDataSource);

  Future close() async {
    await _localDataSource.close();
  }

  Future<Result<List<PiutangModel>>> getAllPiutang(
      {StatusHutangPiutang? status}) async {
    return await errorHandler(() async {
      List<PiutangModel> allPiutang = (await _localDataSource.piutangProvider
              .getAllPiutang(status: status))
          .map((piutangEntity) => mapPiutangEntityToPiutangModel(piutangEntity))
          .toList();
      return Success(data: allPiutang);
    });
  }

  Future<Result<PiutangModel>> insertPiutang(PiutangModel piutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.piutangProvider
          .insert(mapPiutangModelToPiutangEntity(piutang));
      return Success(data: piutang.copyWith(id: id));
    });
  }

  Future<Result<PiutangModel>> updatePiutang(PiutangModel piutang) async {
    return await errorHandler(() async {
      await _localDataSource.piutangProvider
          .update(mapPiutangModelToPiutangEntity(piutang));
      return Success(data: piutang);
    });
  }

  Future<Result<bool>> deletePiutang(PiutangModel piutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.piutangProvider
          .delete(mapPiutangModelToPiutangEntity(piutang));
      return Success(data: id > 0);
    });
  }

  Future<Result<List<AngsuranPiutangModel>>> getAllAngsuranByPiutangId(
      int piutangId) async {
    return await errorHandler(() async {
      List<AngsuranPiutangModel> allAngsuran = (await _localDataSource
              .angsuranPiutangProvider
              .getAngsuranByPiutangId(piutangId))
          .map((angsuranEntity) =>
              mapAngsuranPiutangEntityToAngsuranPiutangModel(angsuranEntity))
          .toList();
      return Success(data: allAngsuran);
    });
  }

  Future<Result<AngsuranPiutangModel>> insertAngsuranPiutang(
      AngsuranPiutangModel angsuranPiutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.angsuranPiutangProvider.insert(
          mapAngsuranPiutangModelToAngsuranPiutangEntity(angsuranPiutang));
      return Success(data: angsuranPiutang.copyWith(id: id));
    });
  }

  Future<Result<AngsuranPiutangModel>> editAngsuranPiutang(
      AngsuranPiutangModel angsuranPiutang) async {
    return await errorHandler(() async {
      await _localDataSource.angsuranPiutangProvider.update(
          mapAngsuranPiutangModelToAngsuranPiutangEntity(angsuranPiutang));
      return Success(data: angsuranPiutang);
    });
  }

  Future<Result<bool>> deleteAngsuranPiutang(
      AngsuranPiutangModel angsuranPiutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.angsuranPiutangProvider.delete(
          mapAngsuranPiutangModelToAngsuranPiutangEntity(angsuranPiutang));
      return Success(data: id > 0);
    });
  }
}
