import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
        version: 1,
        onCreate: _onCreate,
        onDowngrade: onDatabaseDowngradeDelete);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE token (
        id INTEGER PRIMARY KEY,
        token TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        is_uploaded BOOLEAN DEFAULT 0,
        uuid TEXT UNIQUE,
        name TEXT,
        wpass_code TEXT, 
        event_start_at TEXT,
        start_at TEXT,
        is_selected INTEGER DEFAULT 0  
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE tickets (
        uuid TEXT PRIMARY KEY,
        user TEXT,
        event TEXT,
        session TEXT,
        ticket TEXT,
        referer TEXT,
        referer_user TEXT,
        price INTEGER,
        ticket_code TEXT,
        cashless_number TEXT,
        accessed_at TEXT,
        checkin_at TEXT,
        last_entry_at TEXT,
        last_exit_at TEXT,
        is_refundable INTEGER,
        name TEXT,
        dni TEXT,
        birthdate TEXT,
        email TEXT,
        phone TEXT,
        gender TEXT,
        postal_code TEXT,
        age INTEGER,
        question1_text TEXT,
        question1_answer TEXT,
        question2_text TEXT,
        question2_answer TEXT,
        question3_text TEXT,
        question3_answer TEXT,
        numeration TEXT,
        seat_name TEXT,
        start_date TEXT,
        start_date_vip TEXT,
        extra1_title TEXT,
        extra1_text TEXT,
        extra2_title TEXT,
        extra2_text TEXT,
        extra3_title TEXT,
        extra3_text TEXT,
        holder_name TEXT,
        holder_surname TEXT,
        place_name TEXT,
        place_address TEXT
      )
    ''');
  }
}
