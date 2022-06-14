import 'package:hutangin/src/data/datasource/database/entity/angsuran_hutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/provider/base_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class AngsuranHutangProvider implements BaseProvider {
  Database? _db;

  @override
  Future onCreate(Database? db) async {
    await db?.execute('''
      CREATE TABLE ${AngsuranHutangEntity.tableName} (
        ${AngsuranHutangEntity.columnId} integer primary key autoincrement,
        ${AngsuranHutangEntity.columnHutangId} integer not null,
        ${AngsuranHutangEntity.columnNominal} integer not null,
        ${AngsuranHutangEntity.columnTanggalBayar} integer not null,
        ${AngsuranHutangEntity.columnCaraBayar} text,
        ${AngsuranHutangEntity.columnDeskripsi} text,
        ${AngsuranHutangEntity.columnCreatedAt} integer not null,
        ${AngsuranHutangEntity.columnUpdatedAt} integer
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

  Future<List<AngsuranHutangEntity>> getAngsuranByHutangId(int hutangId) async {
    List<Map<String, Object?>>? allAngsuran;
    allAngsuran = await _db?.query(
      AngsuranHutangEntity.tableName,
      where: '${AngsuranHutangEntity.columnHutangId} = ?',
      whereArgs: [
        hutangId,
      ],
    );
    return allAngsuran
            ?.map((angsuran) => AngsuranHutangEntity.fromMap(angsuran))
            .toList() ??
        [];
  }

  Future<int> insert(AngsuranHutangEntity angsuranHutang) async {
    angsuranHutang.createdAt = DateTime.now();

    int? id = await _db?.insert(
      AngsuranHutangEntity.tableName,
      angsuranHutang.toMapWithoutId(),
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menambah angsuran hutang');
  }

  Future<int> update(AngsuranHutangEntity hutang) async {
    hutang.updatedAt = DateTime.now();

    int? id = await _db?.update(
      AngsuranHutangEntity.tableName,
      hutang.toMapWithoutId(),
      where: '${AngsuranHutangEntity.columnId} = ?',
      whereArgs: [
        hutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat mengubah data angsuran piutang');
  }

  Future<int> delete(AngsuranHutangEntity hutang) async {
    int? id = await _db?.delete(
      AngsuranHutangEntity.tableName,
      where: '${AngsuranHutangEntity.columnId} = ?',
      whereArgs: [
        hutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menghapus angsuran piutang');
  }
}
