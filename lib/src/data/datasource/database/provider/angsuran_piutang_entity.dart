import 'package:hutangin/src/data/datasource/database/entity/angsuran_piutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/provider/base_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class AngsuranPiutangProvider implements BaseProvider {
  Database? _db;

  @override
  Future onCreate(Database? db) async {
    await db?.execute('''
      CREATE TABLE ${AngsuranPiutangEntity.tableName} (
        ${AngsuranPiutangEntity.columnId} integer primary key autoincrement,
        ${AngsuranPiutangEntity.columnPiutangId} integer not null,
        ${AngsuranPiutangEntity.columnNominal} integer not null,
        ${AngsuranPiutangEntity.columnTanggalBayar} integer not null,
        ${AngsuranPiutangEntity.columnCaraBayar} text,
        ${AngsuranPiutangEntity.columnDeskripsi} text,
        ${AngsuranPiutangEntity.columnCreatedAt} integer not null,
        ${AngsuranPiutangEntity.columnUpdatedAt} integer
      )
    ''');
  }

  @override
  Future close() async {
    await _db?.close();
  }

  @override
  Future setup(Database db) async {
    _db = db;
  }

  Future<List<AngsuranPiutangEntity>> getAngsuranByPiutangId(
      int piutangId) async {
    List<Map<String, Object?>>? allAngsuran;
    allAngsuran = await _db?.query(
      AngsuranPiutangEntity.tableName,
      where: '${AngsuranPiutangEntity.columnPiutangId} = ?',
      whereArgs: [
        piutangId,
      ],
    );
    return allAngsuran
            ?.map((angsuran) => AngsuranPiutangEntity.fromMap(angsuran))
            .toList() ??
        [];
  }

  Future<int> insert(AngsuranPiutangEntity piutang) async {
    piutang.createdAt = DateTime.now();

    int? id = await _db?.insert(
      AngsuranPiutangEntity.tableName,
      piutang.toMapWithoutId(),
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menambah angsuran piutang');
  }

  Future<int> update(AngsuranPiutangEntity piutang) async {
    piutang.updatedAt = DateTime.now();
    
    int? id = await _db?.update(
      AngsuranPiutangEntity.tableName,
      piutang.toMapWithoutId(),
      where: '${AngsuranPiutangEntity.columnId} = ?',
      whereArgs: [
        piutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat mengubah data angsuran piutang');
  }

  Future<int> delete(AngsuranPiutangEntity piutang) async {
    int? id = await _db?.delete(
      AngsuranPiutangEntity.tableName,
      where: '${AngsuranPiutangEntity.columnId} = ?',
      whereArgs: [
        piutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menghapus angsuran piutang');
  }
}
