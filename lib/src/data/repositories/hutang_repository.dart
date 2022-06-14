import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/data/datasource/local/local_data_source.dart';
import 'package:hutangin/src/data/models/angsuran_hutang_model.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/data/resources/error_handler.dart';
import 'package:hutangin/src/data/resources/mapper.dart';
import 'package:hutangin/src/data/resources/result.dart';

class HutangRepository {
  final LocalDataSource _localDataSource;

  HutangRepository(this._localDataSource);

  Future close() async {
    await _localDataSource.close();
  }

  Future<Result<List<HutangModel>>> getAllHutang(
      {StatusHutangPiutang? status}) async {
    return await errorHandler(() async {
      List<HutangModel> allHutang =
          (await _localDataSource.hutangProvider.getAllHutang(status: status))
              .map((hutangEntity) => mapHutangEntityToHutangModel(hutangEntity))
              .toList();
      return Success(data: allHutang);
    });
  }

  Future<Result<HutangModel>> insertHutang(HutangModel hutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.hutangProvider
          .insert(mapHutangModelToHutangEntity(hutang));
      return Success(data: hutang.copyWith(id: id));
    });
  }

  Future<Result<HutangModel>> updateHutang(HutangModel hutang) async {
    return await errorHandler(() async {
      await _localDataSource.hutangProvider
          .update(mapHutangModelToHutangEntity(hutang));
      return Success(data: hutang);
    });
  }

  Future<Result<bool>> deleteHutang(HutangModel hutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.hutangProvider
          .delete(mapHutangModelToHutangEntity(hutang));
      return Success(data: id > 0);
    });
  }

  Future<Result<List<AngsuranHutangModel>>> getAllAngsuranByHutangId(
      int hutangId) async {
    return await errorHandler(() async {
      List<AngsuranHutangModel> allAngsuran = (await _localDataSource
              .angsuranHutangProvider
              .getAngsuranByHutangId(hutangId))
          .map((angsuranEntity) =>
              mapAngsuranHutangEntityToAngsuranHutangModel(angsuranEntity))
          .toList();
      return Success(data: allAngsuran);
    });
  }

  Future<Result<AngsuranHutangModel>> insertAngsuranHutang(
      AngsuranHutangModel angsuranHutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.angsuranHutangProvider
          .insert(mapAngsuranHutangModelToAngsuranHutangEntity(angsuranHutang));
      return Success(data: angsuranHutang.copyWith(id: id));
    });
  }

  Future<Result<AngsuranHutangModel>> editAngsuranHutang(
      AngsuranHutangModel angsuranHutang) async {
    return await errorHandler(() async {
      await _localDataSource.angsuranHutangProvider
          .update(mapAngsuranHutangModelToAngsuranHutangEntity(angsuranHutang));
      return Success(data: angsuranHutang);
    });
  }

  Future<Result<bool>> deleteAngsuranHutang(
      AngsuranHutangModel angsuranHutang) async {
    return await errorHandler(() async {
      int id = await _localDataSource.angsuranHutangProvider
          .delete(mapAngsuranHutangModelToAngsuranHutangEntity(angsuranHutang));
      return Success(data: id > 0);
    });
  }
}
