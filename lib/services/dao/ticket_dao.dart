import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';
import 'package:woutickpass/services/database.dart';

var CHECKIN_AVAILABLE = true;
var CHECKOUT_AVAILABLE = false;

class TicketDAO {
  static final TicketDAO instance = TicketDAO._privateConstructor();
  TicketDAO._privateConstructor();

  Future<Database> get _db async => await DatabaseHelper().database;

  Future<int> insert(TicketDetails ticket) async {
    Database db = await _db;
    int result = await db.insert('tickets', ticket.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint(
        'Almacenado/Actualizado ticket con UUID ${ticket.uuid}. Resultado: $result');
    return result;
  }

  Future<int> update(TicketDetails ticket) async {
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

  Future<int> deleteTicketsByEvent(String event) async {
    Database db = await _db;
    return await db.delete(
      'tickets',
      where: 'event = ?',
      whereArgs: [event],
    );
  }

  Future<List<TicketDetails>> getTicketsBySessionId(String sessionId) async {
    final db = await _db;
    final maps = await db.query(
      'tickets',
      where: 'session_uuid = ?',
      whereArgs: [sessionId],
    );

    if (maps.isNotEmpty) {
      return maps.map((json) => TicketDetails.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> printAllTickets() async {
    final db = await _db;
    final result = await db
        .query('tickets'); // Consulta todos los tickets en la base de datos
    print("Todos los tickets en la base de datos: $result");
  }

  Future<void> fetchAllTickets() async {
    final db = await _db;
    final result = await db.query('tickets');
    print("Todos los tickets en la base de datos: $result");
  }

  Future<bool> sessionTicketsExist(String sessionId) async {
    Database db = await _db;
    var result = await db.query(
      'tickets',
      where: 'session_uuid = ?', // Cambiado de 'session' a 'session_uuid'
      whereArgs: [sessionId],
    );
    return result.isNotEmpty;
  }

  Future<List<TicketDetails>> getAllTickets() async {
    final db = await instance._db;
    final maps = await db.query('tickets');
    print("Todos los tickets: $maps");
    if (maps.isNotEmpty) {
      return maps.map((json) => TicketDetails.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  Future<TicketDetails?> getTicketById(String uuid) async {
    Database db = await _db;
    var result = await db.query(
      'tickets',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
    return result.isNotEmpty ? TicketDetails.fromMap(result.first) : null;
  }

  Future<List<TicketDetails>> getTicketsByEvent(String event) async {
    Database db = await _db;
    var tickets = await db.query(
      'tickets',
      where: 'event = ?',
      whereArgs: [event],
    );
    return tickets.isNotEmpty
        ? tickets.map((c) => TicketDetails.fromMap(c)).toList()
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

  Future<Map<String, int>> getTicketStatisticsByEvent(String event) async {
    Database db = await _db;

    final checkinsResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM tickets WHERE event = ? AND checkin_at IS NOT NULL',
        [event]);
    final checkinsCount = Sqflite.firstIntValue(checkinsResult) ?? 0;

    final entriesResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM tickets WHERE event = ? AND last_entry_at IS NOT NULL',
        [event]);
    final entriesCount = Sqflite.firstIntValue(entriesResult) ?? 0;

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
