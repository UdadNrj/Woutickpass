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

  Future<List<Map<String, dynamic>>> getTicketTypes() async {
    Database db = await _db;
    var result = await db.rawQuery('SELECT DISTINCT type FROM tickets');
    return result;
  }

  // Nuevo método para verificar si ya existen tickets para una sesión
  Future<bool> sessionTicketsExist(String sessionId) async {
    Database db = await _db;
    var result = await db.query(
      'tickets',
      where: 'session = ?', // Cambiado a 'session'
      whereArgs: [sessionId],
    );
    return result.isNotEmpty;
  }
}
