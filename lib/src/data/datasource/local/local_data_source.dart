import 'package:hutangin/src/data/datasource/database/database_helper.dart';
import 'package:hutangin/src/data/datasource/database/provider/angsuran_hutang_provider.dart';
import 'package:hutangin/src/data/datasource/database/provider/angsuran_piutang_entity.dart';
import 'package:hutangin/src/data/datasource/database/provider/hutang_provider.dart';
import 'package:hutangin/src/data/datasource/database/provider/piutang_provider.dart';

class LocalDataSource {
  final hutangProvider = HutangProvider();
  final piutangProvider = PiutangProvider();
  final angsuranHutangProvider = AngsuranHutangProvider();
  final angsuranPiutangProvider = AngsuranPiutangProvider();

  DatabaseHelper? dbHelper;

  LocalDataSource() {
    dbHelper = DatabaseHelper([
      hutangProvider,
      piutangProvider,
      angsuranHutangProvider,
      angsuranPiutangProvider,
    ]);

    dbHelper?.setup();
  }

  Future close() async {
    dbHelper?.close();
  }
}
