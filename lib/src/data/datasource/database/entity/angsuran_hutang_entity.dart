import 'package:hutangin/src/util/date_util.dart';

class AngsuranHutangEntity {
  static const String tableName = 'angsuran_hutang';
  static const String columnId = 'id';
  static const String columnHutangId = 'hutang_id';
  static const String columnNominal = 'nominal';
  static const String columnTanggalBayar = 'tanggal_bayar';
  static const String columnCaraBayar = 'cara_bayar';
  static const String columnDeskripsi = 'deskripsi';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  int? id;
  int? hutangId;
  int? nominal;
  DateTime? tanggalBayar;
  String? caraBayar;
  String? deskripsi;
  DateTime? createdAt;
  DateTime? updatedAt;

  AngsuranHutangEntity({
    this.id,
    this.hutangId,
    this.nominal,
    this.tanggalBayar,
    this.caraBayar,
    this.deskripsi,
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
      columnHutangId: hutangId,
      columnNominal: nominal,
      columnTanggalBayar: tanggalBayar?.millisecondsSinceEpoch,
      columnCaraBayar: caraBayar,
      columnDeskripsi: deskripsi,
      columnCreatedAt: createdAt?.millisecondsSinceEpoch,
      columnUpdatedAt: updatedAt?.millisecondsSinceEpoch,
    };
  }

  AngsuranHutangEntity.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int?;
    hutangId = map[columnHutangId] as int?;
    nominal = map[columnNominal] as int?;
    tanggalBayar = (map[columnTanggalBayar] as int?).milisToDateTime();
    caraBayar = map[columnCaraBayar] as String?;
    deskripsi = map[columnDeskripsi] as String?;
    createdAt = (map[columnCreatedAt] as int?).milisToDateTime();
    updatedAt = (map[columnUpdatedAt] as int?).milisToDateTime();
  }
}
