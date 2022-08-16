import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> createDatabase() async {
    final path = "${await getDatabasesPath()}/'doggie_database.db";
    final database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER",
        );
      },
      version: 1,
    );
    return database;
  }
}
