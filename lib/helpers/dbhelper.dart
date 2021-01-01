import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dpPath = await sql.getDatabasesPath();
    try {
      return sql.openDatabase(
        path.join(dpPath, "persons.db"),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE persons(id TEXT PRIMARY KEY, firstname TEXT, lastname TEXT, strength TEXT, cuteness REAL)');
        },
        version: 1,
      );
    } catch (error) {
      throw error;
    }
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqldb = await DBHelper.database();
    sqldb.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqldb = await DBHelper.database();
    return sqldb.query(table);
  }
}
