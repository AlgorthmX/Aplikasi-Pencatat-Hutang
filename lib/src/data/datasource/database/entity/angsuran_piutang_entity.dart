import 'package:hutangin/src/util/date_util.dart';

class AngsuranPiutangEntity {
  static const String tableName = 'angsuran_piutang';
  static const String columnId = 'id';
  static const String columnPiutangId = 'piutang_id';
  static const String columnNominal = 'nominal';
  static const String columnTanggalBayar = 'tanggal_bayar';
  static const String columnCaraBayar = 'cara_bayar';
  static const String columnDeskripsi = 'deskripsi';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  int? id;
  int? piutangId;
  int? nominal;
  DateTime? tanggalBayar;
  String? caraBayar;
  String? deskripsi;
  DateTime? createdAt;
  DateTime? updatedAt;

  AngsuranPiutangEntity({
    this.id,
    this.piutangId,
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
      columnPiutangId: piutangId,
      columnNominal: nominal,
      columnTanggalBayar: tanggalBayar?.millisecondsSinceEpoch,
      columnCaraBayar: caraBayar,
      columnDeskripsi: deskripsi,
      columnCreatedAt: createdAt?.millisecondsSinceEpoch,
      columnUpdatedAt: updatedAt?.millisecondsSinceEpoch,
    };
  }

  AngsuranPiutangEntity.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int?;
    piutangId = map[columnPiutangId] as int?;
    nominal = map[columnNominal] as int?;
    tanggalBayar = (map[columnTanggalBayar] as int?).milisToDateTime();
    caraBayar = map[columnCaraBayar] as String?;
    deskripsi = map[columnDeskripsi] as String?;
    createdAt = (map[columnCreatedAt] as int?).milisToDateTime();
    updatedAt = (map[columnUpdatedAt] as int?).milisToDateTime();
  }
}
