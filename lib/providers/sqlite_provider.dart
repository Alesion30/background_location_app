import 'package:background_location_app/utils/sqlite_util.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';

final sqliteProvider = ChangeNotifierProvider<SqliteProvider>((ref) {
  return SqliteProvider(ref);
});

class SqliteProvider extends ChangeNotifier {
  SqliteProvider(this.ref) {
    init();
  }

  final ChangeNotifierProviderRef<SqliteProvider> ref;
  late Database db;

  // locationsテーブル
  static const tableLocation = '''
    CREATE TABLE IF NOT EXISTS Locations (
      id TEXT PRIMARY KEY,
      lat REAL,
      lon REAL,
      timestamp INTEGER
    );''';

  Future<void> init() async {
    final dbPath = await getDbPath();
    db = await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(tableLocation);
        return;
      },
      version: 1,
    );
    notifyListeners();
  }

  Future<void> insert(String tableName, Map<String, Object?> data) async {
    if (kDebugMode) {
      print('insert: $data > $tableName');
    }
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetch(String tableName) async {
    return db.query(tableName);
  }

  Future<void> delete(String tableName) async {
    if (kDebugMode) {
      print('delete: $tableName');
    }
    await db.delete(tableName);
  }
}
