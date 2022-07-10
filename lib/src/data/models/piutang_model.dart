import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';

class PiutangModel {
  final int id;
  final String namaPeminjam;
  final int nominal;
  final int dibayar;
  final DateTime tanggalPinjam;
  final String deskripsi;
  final StatusHutangPiutang status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  PiutangModel({
    required this.id,
    required this.namaPeminjam,
    required this.nominal,
    required this.dibayar,
    required this.tanggalPinjam,
    required this.deskripsi,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  PiutangModel copyWith({
    int? id,
    String? namaPeminjam,
    int? nominal,
    int? dibayar,
    DateTime? tanggalPinjam,
    String? deskripsi,
    StatusHutangPiutang? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PiutangModel(
      id: id ?? this.id,
      namaPeminjam: namaPeminjam ?? this.namaPeminjam,
      nominal: nominal ?? this.nominal,
      dibayar: dibayar ?? this.dibayar,
      tanggalPinjam: tanggalPinjam ?? this.tanggalPinjam,
      deskripsi: deskripsi ?? this.deskripsi,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
