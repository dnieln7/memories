import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {

  static Future<Database> getDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'memories.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE tb_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> get(String table) async {
    final database = await DBHelper.getDatabase();
    return database.query(table);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DBHelper.getDatabase();
    await database.insert(
        table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
