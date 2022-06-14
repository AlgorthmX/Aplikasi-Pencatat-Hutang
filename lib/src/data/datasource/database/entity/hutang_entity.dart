import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/util/date_util.dart';

class HutangEntity {
  static const String tableName = 'hutang';
  static const String columnId = 'id';
  static const String columnNamaPemberiPinjaman = 'nama_pemberi_pinjaman';
  static const String columnNominal = 'nominal';
  static const String columnSisa = 'sisa';
  static const String columnTanggalPinjam = 'tanggal_pinjam';
  static const String columnDeskripsi = 'deskripsi';
  static const String columnStatus = 'status';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  int? id;
  String? namaPemberiPinjaman;
  int? nominal;
  int? sisa;
  DateTime? tanggalPinjam;
  String? deskripsi;
  StatusHutangPiutang? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  HutangEntity({
    this.id,
    this.namaPemberiPinjaman,
    this.nominal,
    this.sisa,
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
      columnNamaPemberiPinjaman: namaPemberiPinjaman,
      columnNominal: nominal,
      columnSisa: sisa,
      columnTanggalPinjam: tanggalPinjam?.millisecondsSinceEpoch,
      columnDeskripsi: deskripsi,
      columnStatus: status?.name,
      columnCreatedAt: createdAt?.millisecondsSinceEpoch,
      columnUpdatedAt: updatedAt?.millisecondsSinceEpoch,
    };
  }

  HutangEntity.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int?;
    namaPemberiPinjaman = map[columnNamaPemberiPinjaman] as String?;
    nominal = map[columnNominal] as int?;
    sisa = map[columnSisa] as int?;
    tanggalPinjam = (map[columnNominal] as int?).milisToDateTime();
    deskripsi = map[columnDeskripsi] as String?;
    status = (map[columnStatus] as String?).toStatusHutangPiutang();
    createdAt = (map[columnCreatedAt] as int?).milisToDateTime();
    updatedAt = (map[columnUpdatedAt] as int?).milisToDateTime();
  }
}