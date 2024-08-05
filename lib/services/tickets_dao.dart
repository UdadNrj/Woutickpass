import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/services/database.dart';

class TicketsDao {
  static final TicketsDao instance = TicketsDao._privateConstructor();
  TicketsDao._privateConstructor();

  Future<Database> get _db async => await DatabaseHelper().database;

  Future<int> insert(Ticket ticket) async {
    Database db = await _db;
    return await db.insert('tickets', ticket.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(Ticket ticket) async {
    Database db = await _db;
    return await db.update(
      'tickets',
      ticket.toMap(),
      where: 'uuid = ?',
      whereArgs: [ticket.uuid],
    );
  }

  Future<int> delete(String uuid) async {
    Database db = await _db;
    return await db.delete(
      'tickets',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<List<Ticket>> getAllTickets() async {
    Database db = await _db;
    var tickets = await db.query('tickets');
    return tickets.isNotEmpty
        ? tickets.map((c) => Ticket.fromMap(c)).toList()
        : [];
  }

  Future<Ticket?> getTicketById(String uuid) async {
    Database db = await _db;
    var result = await db.query(
      'tickets',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
    return result.isNotEmpty ? Ticket.fromMap(result.first) : null;
  }

  Future<List<Ticket>> getTicketsByEvent(String event) async {
    Database db = await _db;
    var tickets = await db.query(
      'tickets',
      where: 'event = ?',
      whereArgs: [event],
    );
    return tickets.isNotEmpty
        ? tickets.map((c) => Ticket.fromMap(c)).toList()
        : [];
  }

  Future<List<Map<String, dynamic>>> getEventTitles() async {
    Database db = await _db;
    var result = await db.rawQuery('SELECT DISTINCT event FROM tickets');
    return result;
  }

  Future<List<String>> getTicketTypes() async {
    Database db = await _db;
    var result = await db.rawQuery('SELECT DISTINCT type FROM tickets');
    return result.map((row) => row['type'] as String).toList();
  }

  // Método para verificar si ya existen tickets para una sesión
  Future<bool> sessionTicketsExist(String sessionId) async {
    Database db = await _db;
    var result = await db.query(
      'tickets',
      where: 'session = ?', // Cambiado a 'session'
      whereArgs: [sessionId],
    );
    return result.isNotEmpty;
  }

  // Nuevo método para obtener estadísticas de tickets para un evento específico
  Future<Map<String, int>> getTicketStatisticsByEvent(String event) async {
    Database db = await _db;

    // Contar check-ins
    final checkinsResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM tickets WHERE event = ? AND checkin_at IS NOT NULL',
        [event]);
    final checkinsCount = Sqflite.firstIntValue(checkinsResult) ?? 0;

    // Contar entradas (last_entry_at)
    final entriesResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM tickets WHERE event = ? AND last_entry_at IS NOT NULL',
        [event]);
    final entriesCount = Sqflite.firstIntValue(entriesResult) ?? 0;

    // Contar salidas (last_exit_at)
    final exitsResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM tickets WHERE event = ? AND last_exit_at IS NOT NULL',
        [event]);
    final exitsCount = Sqflite.firstIntValue(exitsResult) ?? 0;

    return {
      'checkins': checkinsCount,
      'entries': entriesCount,
      'exits': exitsCount,
    };
  }

  // Nuevo método para obtener estadísticas por tipo de ticket para un evento específico
  Future<Map<String, int>> getTicketTypeStatistics(String event) async {
    Database db = await _db;

    final result = await db.rawQuery(
        'SELECT type, COUNT(*) AS count FROM tickets WHERE event = ? GROUP BY type',
        [event]);

    final typeStats = <String, int>{};
    for (var row in result) {
      typeStats[row['type'] as String] = row['count'] as int;
    }

    return typeStats;
  }
}
