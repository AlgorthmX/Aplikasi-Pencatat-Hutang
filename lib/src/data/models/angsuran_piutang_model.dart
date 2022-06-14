class AngsuranPiutangModel {
  final int id;
  final int piutangId;
  final int nominal;
  final DateTime tanggalBayar;
  final String caraBayar;
  final String deskripsi;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AngsuranPiutangModel({
    required this.id,
    required this.piutangId,
    required this.nominal,
    required this.tanggalBayar,
    required this.caraBayar,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  AngsuranPiutangModel copyWith({
    int? id,
    int? piutangId,
    int? nominal,
    DateTime? tanggalBayar,
    String? caraBayar,
    String? deskripsi,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AngsuranPiutangModel(
      id: id ?? this.id,
      piutangId: piutangId ?? this.piutangId,
      nominal: nominal ?? this.nominal,
      tanggalBayar: tanggalBayar ?? this.tanggalBayar,
      caraBayar: caraBayar ?? this.caraBayar,
      deskripsi: deskripsi ?? this.deskripsi,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
