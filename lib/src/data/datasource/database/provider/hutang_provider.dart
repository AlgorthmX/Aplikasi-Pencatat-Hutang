import 'package:hutangin/src/data/datasource/database/entity/hutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/data/datasource/database/provider/base_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class HutangProvider implements BaseProvider {
  Database? _db;

  @override
  Future onCreate(Database? db) async {
    await db?.execute('''
      CREATE TABLE ${HutangEntity.tableName} (
        ${HutangEntity.columnId} integer primary key autoincrement,
        ${HutangEntity.columnNamaPemberiPinjaman} text not null, 
        ${HutangEntity.columnNominal} integer not null, 
        ${HutangEntity.columnTanggalPinjam} integer not null,
        ${HutangEntity.columnDeskripsi} text,
        ${HutangEntity.columnStatus} text not null,
        ${HutangEntity.columnCreatedAt} integer not null,
        ${HutangEntity.columnUpdatedAt} integer
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

  Future<List<HutangEntity>> getAllHutang({StatusHutangPiutang? status}) async {
    List<Map<String, Object?>>? allHutang;
    if (status != null) {
      allHutang = await _db?.query(
        HutangEntity.tableName,
        where: '${HutangEntity.columnStatus} = ?',
        whereArgs: [
          status,
        ],
      );
    } else {
      allHutang = await _db?.query(
        HutangEntity.tableName,
      );
    }
    return allHutang?.map((hutang) => HutangEntity.fromMap(hutang)).toList() ??
        [];
  }

  Future<int> insert(HutangEntity hutang) async {
    hutang.createdAt = DateTime.now();

    int? id = await _db?.insert(
      HutangEntity.tableName,
      hutang.toMapWithoutId(),
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menambah hutang');
  }

  Future<int> update(HutangEntity hutang) async {
    hutang.updatedAt = DateTime.now();

    int? id = await _db?.update(
      HutangEntity.tableName,
      hutang.toMapWithoutId(),
      where: '${HutangEntity.columnId} = ?',
      whereArgs: [
        hutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat mengedit data hutang');
  }

  Future<int> delete(HutangEntity hutang) async {
    int? id = await _db?.delete(
      HutangEntity.tableName,
      where: '${HutangEntity.columnId} = ?',
      whereArgs: [
        hutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menghapus hutang');
  }
}
