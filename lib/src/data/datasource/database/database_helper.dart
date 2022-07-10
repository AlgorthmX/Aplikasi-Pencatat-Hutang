import 'package:hutangin/src/data/datasource/database/provider/base_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  final int _databaseVersion = 1;

  List<BaseProvider> providers;

  DatabaseHelper(this.providers);

  Database? _database;

  Future<Database> setup() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    await _setupDatabase();
    return _database!;
  }

  Future<void> _setupDatabase() async {
    for (var provider in providers) {
      await provider.setup(_database!);
    }
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'HutangIn.db';
    String path = join(databasePath, databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    for (var provider in providers) {
      await provider.onCreate(db);
    }
  }

  Future close() async {
    for(var provider in providers) {
      await provider.close();
    }
  }
}
