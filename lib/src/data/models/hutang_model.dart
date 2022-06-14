import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';

class HutangModel {
  final int id;
  final String namaPemberiPinjaman;
  final int nominal;
  final int sisa;
  final DateTime tanggalPinjam;
  final String deskripsi;
  final StatusHutangPiutang status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  HutangModel({
    required this.id,
    required this.namaPemberiPinjaman,
    required this.nominal,
    required this.sisa,
    required this.tanggalPinjam,
    required this.deskripsi,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  HutangModel copyWith({
    int? id,
    String? namaPemberiPinjaman,
    int? nominal,
    int? sisa,
    DateTime? tanggalPinjam,
    String? deskripsi,
    StatusHutangPiutang? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HutangModel(
      id: id ?? this.id,
      namaPemberiPinjaman: namaPemberiPinjaman ?? this.namaPemberiPinjaman,
      nominal: nominal ?? this.nominal,
      sisa: sisa ?? this.sisa,
      tanggalPinjam: tanggalPinjam ?? this.tanggalPinjam,
      deskripsi: deskripsi ?? this.deskripsi,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
