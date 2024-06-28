import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tokens(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      token TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE events(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      uuid TEXT NOT NULL,
      name TEXT NOT NULL,
      wpassCode TEXT NOT NULL,
      eventStartAt TEXT NOT NULL,
      startAt TEXT NOT NULL
    )
    ''');
  }
}
