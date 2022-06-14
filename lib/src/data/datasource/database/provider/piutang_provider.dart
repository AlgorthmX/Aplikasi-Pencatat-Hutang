import 'package:hutangin/src/data/datasource/database/entity/piutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/data/datasource/database/provider/base_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class PiutangProvider implements BaseProvider {
  Database? _db;

  @override
  Future onCreate(Database? db) async {
    await db?.execute('''
      CREATE TABLE ${PiutangEntity.tableName} (
        ${PiutangEntity.columnId} integer primary key autoincrement,
        ${PiutangEntity.columnNamaPeminjam} text not null, 
        ${PiutangEntity.columnNominal} integer not null, 
        ${PiutangEntity.columnTanggalPinjam} integer not null,
        ${PiutangEntity.columnDeskripsi} text,
        ${PiutangEntity.columnStatus} text not null,
        ${PiutangEntity.columnCreatedAt} integer not null,
        ${PiutangEntity.columnUpdatedAt} integer
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

  Future<List<PiutangEntity>> getAllPiutang(
      {StatusHutangPiutang? status}) async {
    List<Map<String, Object?>>? allPiutang;
    if (status != null) {
      allPiutang = await _db?.query(
        PiutangEntity.tableName,
        where: '${PiutangEntity.columnStatus} = ?',
        whereArgs: [
          status,
        ],
      );
    } else {
      allPiutang = await _db?.query(
        PiutangEntity.tableName,
      );
    }
    return allPiutang
            ?.map((hutang) => PiutangEntity.fromMap(hutang))
            .toList() ??
        [];
  }

  Future<int> insert(PiutangEntity piutang) async {
    piutang.createdAt = DateTime.now();

    int? id = await _db?.insert(
      PiutangEntity.tableName,
      piutang.toMapWithoutId(),
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menambah piutang');
  }

  Future<int> update(PiutangEntity piutang) async {
    piutang.updatedAt = DateTime.now();

    int? id = await _db?.update(
      PiutangEntity.tableName,
      piutang.toMapWithoutId(),
      where: '${PiutangEntity.columnId} = ?',
      whereArgs: [
        piutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat mengubah data piutang');
  }

  Future<int> delete(PiutangEntity piutang) async {
    int? id = await _db?.delete(
      PiutangEntity.tableName,
      where: '${PiutangEntity.columnId} = ?',
      whereArgs: [
        piutang.id,
      ],
    );
    if (id != null && id > 0) {
      return id;
    }
    throw Exception('Terjadi kesalahan saat menghapus piutang');
  }
}
