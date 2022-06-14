class AngsuranHutangModel {
  final int id;
  final int hutangId;
  final int nominal;
  final DateTime tanggalBayar;
  final String caraBayar;
  final String deskripsi;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AngsuranHutangModel({
    required this.id,
    required this.hutangId,
    required this.nominal,
    required this.tanggalBayar,
    required this.caraBayar,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  AngsuranHutangModel copyWith({
    int? id,
    int? hutangId,
    int? nominal,
    DateTime? tanggalBayar,
    String? caraBayar,
    String? deskripsi,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AngsuranHutangModel(
      id: id ?? this.id,
      hutangId: hutangId ?? this.hutangId,
      nominal: nominal ?? this.nominal,
      tanggalBayar: tanggalBayar ?? this.tanggalBayar,
      caraBayar: caraBayar ?? this.caraBayar,
      deskripsi: deskripsi ?? this.deskripsi,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
