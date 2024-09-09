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
      version: 1, // Mantén la versión en 1 si eliminas la base de datos
      onCreate: _onCreate,
      onDowngrade: onDatabaseDowngradeDelete,
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
        created_at TEXT,
        updated_at TEXT,
        is_featured INTEGER,
        is_private INTEGER,
        is_canceled INTEGER,
        order_number INTEGER,  
        name TEXT,
        slug TEXT,
        description TEXT,
        text_out_of_stock TEXT,
        text_not_available TEXT,
        streaming_url TEXT,
        streaming_description TEXT,
        streaming_free_access INTEGER,
        public_start_at TEXT,
        public_end_at TEXT,
        start_at TEXT,
        end_at TEXT,
        doors_open_time TEXT,
        is_cashless INTEGER,
        returns_start_at TEXT,
        returns_end_at TEXT,
        returns_min_amount INTEGER,
        has_sell_max INTEGER,
        sell_max INTEGER,
        sell_max_type TEXT,
        tickets_total INTEGER,
        tickets_sold INTEGER,
        has_settlement INTEGER, 
        status TEXT,
        event_venue TEXT,
        text_offering TEXT,
        tickets TEXT
    )
    ''');
    await db.execute('''
  CREATE TABLE tickets (
    uuid TEXT PRIMARY KEY,
    payment_at TEXT,
    created_at TEXT,
    updated_at TEXT,
    session TEXT,
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
    question2_text TEXT, -- Asegúrate de que esta columna esté incluida
    question2_answer TEXT, -- Asegúrate de que esta columna esté incluida
    question3_text TEXT, -- Asegúrate de que esta columna esté incluida
    question3_answer TEXT, -- Asegúrate de que esta columna esté incluida
    referer_user_full_name TEXT,
    banned_at TEXT,
    refund_at TEXT -- Asegúrate de que esta columna esté incluida
  )
''');
  }
}
