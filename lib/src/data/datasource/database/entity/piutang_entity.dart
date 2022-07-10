import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/util/date_util.dart';

class PiutangEntity {
  static const String tableName = 'piutang';
  static const String columnId = 'id';
  static const String columnNamaPeminjam = 'nama_peminjam';
  static const String columnNominal = 'nominal';
  static const String columnDibayar = 'dibayar';
  static const String columnTanggalPinjam = 'tanggal_pinjam';
  static const String columnDeskripsi = 'deskripsi';
  static const String columnStatus = 'status';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';
  static const String columnDeletedAt = 'deleted_at';

  int? id;
  String? namaPeminjam;
  int? nominal;
  int? dibayar;
  DateTime? tanggalPinjam;
  String? deskripsi;
  StatusHutangPiutang? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  PiutangEntity({
    this.id,
    this.namaPeminjam,
    this.nominal,
    this.dibayar,
    this.tanggalPinjam,
    this.deskripsi,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = toMapWithoutId();
    data[columnId] = id;
    return data;
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      columnNamaPeminjam: namaPeminjam,
      columnNominal: nominal,
      columnDibayar: dibayar,
      columnTanggalPinjam: tanggalPinjam?.millisecondsSinceEpoch,
      columnDeskripsi: deskripsi,
      columnStatus: status?.name,
      columnCreatedAt: createdAt?.millisecondsSinceEpoch,
      columnUpdatedAt: updatedAt?.millisecondsSinceEpoch,
    };
  }

  PiutangEntity.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int?;
    namaPeminjam = map[columnNamaPeminjam] as String?;
    nominal = map[columnNominal] as int?;
    dibayar = map[columnDibayar] as int?;
    tanggalPinjam = (map[columnTanggalPinjam] as int?).milisToDateTime();
    deskripsi = map[columnDeskripsi] as String?;
    status = (map[columnStatus] as String?).toStatusHutangPiutang();
    createdAt = (map[columnCreatedAt] as int?).milisToDateTime();
    updatedAt = (map[columnUpdatedAt] as int?).milisToDateTime();
  }
}