import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:woutickpass/models/Sessions_objeto..dart';



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
        version: 3, 
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: onDatabaseDowngradeDelete  
    );
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
        uuid TEXT UNIQUE,
        name TEXT,
        wpass_code TEXT, 
        event_start_at TEXT,
        start_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE selected_sessions (
        uuid TEXT PRIMARY KEY
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


  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE selected_events (
          uuid TEXT PRIMARY KEY
        )
      ''');
    }
    if (oldVersion < 3) {
      await db.execute('''
        ALTER TABLE events ADD COLUMN wpass_code TEXT;
      ''');
    }
  }

  // Methods  token
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

  // Methods Settings
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

  // Methods Sessions
Future<void> addSession(Sessions session) async {
  final db = await database;
  await db.insert(
    'sessions',
    session.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,  
  );
}

Future<void> removeSession(String uuid) async {
  final db = await database;
  await db.delete(
    'sessions',
    where: 'uuid = ?',
    whereArgs: [uuid],
  );
}

Future<void> clearSessions() async {
  final db = await database;
  await db.delete('sessions');
}

Future<List<Sessions>> getSelectedSessions() async {
  final db = await database;
  final List<String> selectedUuids = await retrieveSelectedSessions();
  final List<Map<String, dynamic>> maps = await db.query(
    'sessions',
    where: 'uuid IN (${selectedUuids.map((_) => '?').join(',')})',
    whereArgs: selectedUuids,
  );
  return List.generate(maps.length, (i) {
    return Sessions.fromJson(maps[i]);
  });
}

Future<void> storeSessions(List<Sessions> sessions) async {
  final db = await database;
  await db.delete('sessions');
  for (var session in sessions) {
    await db.insert(
      'sessions',
      session.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

Future<List<Sessions>> retrieveSessions() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('sessions');
  return List.generate(maps.length, (i) {
    return Sessions.fromJson(maps[i]);
  });
}

Future<void> updateSelectedSessions(List<String> sessionUuids) async {
  final db = await database;
  await db.delete('selected_sessions');
  for (var uuid in sessionUuids) {
    await db.insert(
      'selected_sessions',
      {'uuid': uuid},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

Future<List<String>> retrieveSelectedSessions() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('selected_sessions');
  return List.generate(maps.length, (i) {
    return maps[i]['uuid'] as String;
  });
}

Future<void> addSessionToSelectedSessions(String uuid) async {
  final db = await database;
  await db.insert(
    'selected_sessions',
    {'uuid': uuid},
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<void> removeSessionFromSelectedSessions(String uuid) async {
  final db = await database;
  await db.delete(
    'selected_sessions',
    where: 'uuid = ?',
    whereArgs: [uuid],
  );
}

Future<void> clearSelectedSessions() async {
  final db = await database;
  await db.delete('selected_sessions');
}


  // // Methods sessions
  // Future<void> insertSession(Session session) async {
  //   final db = await database;
  //   await db.insert('sessions', session.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Future<Session?> getSessionByUuid(String uuid) async {
  //   final db = await database;
  //   final result = await db.query('sessions', where: 'uuid = ?', whereArgs: [uuid]);
  //   if (result.isNotEmpty) {
  //     return Session.fromJson(result.first);
  //   }
  //   return null;
  // }

  // Future<List<Session>> getAllSessions() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('sessions');
  //   return List.generate(maps.length, (i) {
  //     return Session.fromJson(maps[i]);
  //   });
  // }

  // Future<void> updateSession(Session session) async {
  //   final db = await database;
  //   await db.update('sessions', session.toJson(), where: 'uuid = ?', whereArgs: [session.uuid]);
  // }

  // Future<void> deleteSession(String uuid) async {
  //   final db = await database;
  //   await db.delete('sessions', where: 'uuid = ?', whereArgs: [uuid]);
  // }

  // Methods out sesión
  Future<void> logout() async {
    await deleteToken();
  }
}
