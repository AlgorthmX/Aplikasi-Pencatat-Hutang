import 'package:hutangin/src/data/datasource/database/entity/angsuran_hutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/angsuran_piutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/hutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/piutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/entity/status_hutang_piutang.dart';
import 'package:hutangin/src/data/models/angsuran_hutang_model.dart';
import 'package:hutangin/src/data/models/angsuran_piutang_model.dart';
import 'package:hutangin/src/data/models/hutang_model.dart';
import 'package:hutangin/src/data/models/piutang_model.dart';

HutangModel mapHutangEntityToHutangModel(HutangEntity hutang) {
  return HutangModel(
    id: hutang.id ?? -1,
    namaPemberiPinjaman: hutang.namaPemberiPinjaman ?? "Tidak diketahui",
    nominal: hutang.nominal ?? -1,
    tanggalPinjam: hutang.tanggalPinjam ?? DateTime.now(),
    deskripsi: hutang.deskripsi ?? "Tidak diketahui",
    status: hutang.status ?? StatusHutangPiutang.belumLunas,
    createdAt: hutang.createdAt ?? DateTime.now(),
    updatedAt: hutang.updatedAt,
  );
}

HutangEntity mapHutangModelToHutangEntity(HutangModel hutang) {
  return HutangEntity(
    id: hutang.id,
    namaPemberiPinjaman: hutang.namaPemberiPinjaman,
    nominal: hutang.nominal,
    tanggalPinjam: hutang.tanggalPinjam,
    deskripsi: hutang.deskripsi,
    status: hutang.status,
    createdAt: hutang.createdAt,
    updatedAt: hutang.updatedAt,
  );
}

PiutangModel mapPiutangEntityToPiutangModel(PiutangEntity piutang) {
  return PiutangModel(
    id: piutang.id ?? -1,
    namaPeminjam: piutang.namaPeminjam ?? "Tidak diketahui",
    nominal: piutang.nominal ?? -1,
    tanggalPinjam: piutang.tanggalPinjam ?? DateTime.now(),
    deskripsi: piutang.deskripsi ?? "Tidak diketahui",
    status: piutang.status ?? StatusHutangPiutang.belumLunas,
    createdAt: piutang.createdAt ?? DateTime.now(),
    updatedAt: piutang.updatedAt,
  );
}

PiutangEntity mapPiutangModelToPiutangEntity(PiutangModel piutang) {
  return PiutangEntity(
    id: piutang.id,
    namaPeminjam: piutang.namaPeminjam,
    nominal: piutang.nominal,
    tanggalPinjam: piutang.tanggalPinjam,
    deskripsi: piutang.deskripsi,
    status: piutang.status,
    createdAt: piutang.createdAt,
    updatedAt: piutang.updatedAt,
  );
}

AngsuranHutangModel mapAngsuranHutangEntityToAngsuranHutangModel(
    AngsuranHutangEntity hutang) {
  return AngsuranHutangModel(
    id: hutang.id ?? -1,
    hutangId: hutang.hutangId ?? -1,
    deskripsi: hutang.deskripsi ?? "Tidak diketahui",
    caraBayar: hutang.caraBayar ?? "Tidak diketahui",
    nominal: hutang.nominal ?? -1,
    tanggalBayar: hutang.tanggalBayar ?? DateTime.now(),
    createdAt: hutang.createdAt ?? DateTime.now(),
    updatedAt: hutang.updatedAt,
  );
}

AngsuranHutangEntity mapAngsuranHutangModelToAngsuranHutangEntity(
    AngsuranHutangModel hutang) {
  return AngsuranHutangEntity(
    id: hutang.id,
    hutangId: hutang.hutangId,
    caraBayar: hutang.caraBayar,
    tanggalBayar: hutang.tanggalBayar,
    nominal: hutang.nominal,
    deskripsi: hutang.deskripsi,
    createdAt: hutang.createdAt,
    updatedAt: hutang.updatedAt,
  );
}

AngsuranPiutangModel mapAngsuranPiutangEntityToAngsuranPiutangModel(
    AngsuranPiutangEntity piutang) {
  return AngsuranPiutangModel(
    id: piutang.id ?? -1,
    piutangId: piutang.piutangId ?? -1,
    deskripsi: piutang.deskripsi ?? "Tidak diketahui",
    caraBayar: piutang.caraBayar ?? "Tidak diketahui",
    nominal: piutang.nominal ?? -1,
    tanggalBayar: piutang.tanggalBayar ?? DateTime.now(),
    createdAt: piutang.createdAt ?? DateTime.now(),
    updatedAt: piutang.updatedAt,
  );
}

AngsuranPiutangEntity mapAngsuranPiutangModelToAngsuranPiutangEntity(
    AngsuranPiutangModel piutang) {
  return AngsuranPiutangEntity(
    id: piutang.id,
    piutangId: piutang.piutangId,
    caraBayar: piutang.caraBayar,
    tanggalBayar: piutang.tanggalBayar,
    nominal: piutang.nominal,
    deskripsi: piutang.deskripsi,
    createdAt: piutang.createdAt,
    updatedAt: piutang.updatedAt,
  );
}
