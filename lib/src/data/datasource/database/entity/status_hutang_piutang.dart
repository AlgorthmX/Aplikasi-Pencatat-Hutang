enum StatusHutangPiutang {
  lunas, 
  belumLunas,
}

extension StatusHutangPiutangExtension on StatusHutangPiutang {

  String get status {
    switch (this) {
      case StatusHutangPiutang.lunas:
        return 'lunas';
      case StatusHutangPiutang.belumLunas:
        return 'belum lunas';
    }
  }
}

extension StringToStatusHutangPiutang on String? {
  StatusHutangPiutang toStatusHutangPiutang() {
    if (this != null) {
      if (this == StatusHutangPiutang.lunas.name) {
        return StatusHutangPiutang.lunas;
      }
      return StatusHutangPiutang.belumLunas;
    }

    return StatusHutangPiutang.belumLunas;
  }
}
