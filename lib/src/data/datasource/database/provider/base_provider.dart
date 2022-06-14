import 'package:sqflite/sqlite_api.dart';

class BaseProvider {
  Future onCreate(Database? db) async {}

  Future close() async {}

  Future setup(Database db) async {}
}