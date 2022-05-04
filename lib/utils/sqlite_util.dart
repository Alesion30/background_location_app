import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// データベースのパスを返す
Future<String> getDbPath() async {
  // final dbDirectory = await getApplicationSupportDirectory();
  // final dbFilePath = dbDirectory.path;
  // final path = join(dbFilePath, 'app.db');
  final path = join(await getDatabasesPath(), 'core1.db');
  return path;
}
