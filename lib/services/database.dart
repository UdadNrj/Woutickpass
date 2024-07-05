import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:woutickpass/models/events_objeto..dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE token (
        id INTEGER PRIMARY KEY,
        token TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT UNIQUE,
        name TEXT,
        date TEXT,
        location TEXT,
        details TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value INTEGER
      )
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE settings (
          key TEXT PRIMARY KEY,
          value INTEGER
        )
      ''');
    }
  }

  // Token Methods

  Future<void> insertToken(String token) async {
    final db = await database;
    await db.insert('token', {'token': token},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> retrieveToken() async {
    final db = await database;
    final result = await db.query('token');
    if (result.isNotEmpty) {
      return result.first['token'] as String?;
    }
    return null;
  }

  Future<void> deleteToken() async {
    final db = await database;
    await db.delete('token');
  }

  // Event Methods

  Future<void> addEvent(Event event) async {
    final db = await database;
    await db.insert('events', event.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeEvent(String uuid) async {
    final db = await database;
    await db.delete('events', where: 'uuid = ?', whereArgs: [uuid]);
  }

  Future<List<Event>> getSelectedEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events');

    return List.generate(maps.length, (i) {
      return Event.fromJson(maps[i]);
    });
  }

  // Settings Methods

  Future<void> saveSetting(String key, bool value) async {
    final db = await database;
    await db.insert(
      'settings',
      {'key': key, 'value': value ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> loadSetting(String key, bool defaultValue) async {
    final db = await database;
    final result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (result.isNotEmpty) {
      return result.first['value'] == 1;
    }
    return defaultValue;
  }

  Future<void> deleteSetting(String key) async {
    final db = await database;
    await db.delete(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
  }

  // Logout Method
  Future<void> logout() async {
    await deleteToken();
  }
}
