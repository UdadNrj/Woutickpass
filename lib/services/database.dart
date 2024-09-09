import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    // Eliminar la base de datos para recrearla
    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE token (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        token TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT UNIQUE,
        title TEXT,
        subtitle TEXT,
        wpass_code TEXT, 
        public_start_at TEXT, 
        public_end_at TEXT,  
        is_selected INTEGER DEFAULT 0,
        commercials TEXT, 
        tickets TEXT 
       )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        wid INTEGER PRIMARY KEY AUTOINCREMENT,
        setting_key TEXT NOT NULL,
        setting_value INTEGER NOT NULL
      )
    ''');

    await db.execute('''
    CREATE TABLE session_details (
      uuid TEXT PRIMARY KEY,
      is_active INTEGER,
      is_canceled INTEGER,
      name TEXT,
      subtitle TEXT,
      public_start_at TEXT,
      public_end_at TEXT,
      commercials TEXT,  -- Esto puede ser un JSON serializado
      tickets TEXT       -- Esto puede ser un JSON serializado
    )
  ''');

    await db.execute('''
    CREATE TABLE tickets (
      uuid TEXT PRIMARY KEY,
      payment_at TEXT,
      created_at TEXT,
      updated_at TEXT,
      session_uuid TEXT,  -- Clave externa que referencia session_details
      event TEXT,
      status TEXT,
      ticket_code TEXT,
      ticket_name TEXT,
      type TEXT,
      price_public INTEGER,
      commission_public INTEGER,
      accessed_at TEXT,
      checkin_at TEXT,
      last_entry_at TEXT,
      last_exit_at TEXT,
      name TEXT,
      dni TEXT,
      birthdate TEXT,
      postal_code TEXT,
      email TEXT,
      phone TEXT,
      gender TEXT,
      question1_text TEXT,
      question1_answer TEXT,
      question2_text TEXT,
      question2_answer TEXT,
      question3_text TEXT,
      question3_answer TEXT,
      referer_user_full_name TEXT,
      banned_at TEXT,
      refund_at TEXT,
      FOREIGN KEY (session_uuid) REFERENCES session_details(uuid) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE commercials (
      uuid TEXT PRIMARY KEY,
      name TEXT,
      session_uuid TEXT,  -- Clave externa que referencia session_details
      FOREIGN KEY (session_uuid) REFERENCES session_details(uuid) ON DELETE CASCADE
    )
  ''');
  }

  Future<List<Map<String, dynamic>>> getTicketsForSession(
      String sessionId) async {
    final db = await database;
    return await db.query(
      'tickets',
      where: 'session_uuid = ?',
      whereArgs: [sessionId],
    );
  }
}
