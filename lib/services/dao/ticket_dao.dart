import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/services/database.dart';

var CHECKIN_AVAILABLE = true;
var CHECKOUT_AVAILABLE = false;

class TicketDAO {
  static final TicketDAO instance = TicketDAO._privateConstructor();
  TicketDAO._privateConstructor();

  Future<Database> get _db async => await DatabaseHelper().database;

  Future<int> insert(Ticket ticket) async {
    Database db = await _db;
    int result = await db.insert('tickets', ticket.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint(
        'Insertado/Actualizado ticket con UUID ${ticket.uuid}. Resultado: $result');
    return result;
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

  Future<int> deleteTicketsByEvent(String event) async {
    Database db = await _db;
    return await db.delete(
      'tickets',
      where: 'event = ?',
      whereArgs: [event],
    );
  }

  Future<List<Ticket>> getTicketsBySessionId(String sessionId) async {
    final db = await instance._db;
    final maps = await db.query(
      'tickets',
      where: 'session = ?',
      whereArgs: [sessionId],
    );

    if (maps.isNotEmpty) {
      return maps.map((json) => Ticket.fromMap(json)).toList();
    } else {
      return [];
    }
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

  Future<bool> sessionTicketsExist(String sessionId) async {
    Database db = await _db;
    var result = await db.query(
      'tickets',
      where: 'session = ?',
      whereArgs: [sessionId],
    );
    return result.isNotEmpty;
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

// Future<void> checkIn(int ticketId) async {
//   final ticket = await TicketDatabase.instance.getTicket(ticketId);
//   if (ticket = null) {
//     print("no se encuentra ticketId");
//     print(ticketId);
//     return;
//   }
//   if (ticket.lastEntryAt = null ||
//       ticket.lastExitAt != null && ticket.lastExitAt > ticket.lastEntryA) {
//     if (!CHECKIN_AVAILABLE) {
//       print("este dispositivo tiene desactivadas las entradas");
//       return;
//     }
//     final now = DateTime.now().toIso8601String();
//     ticket.lastEntryAt = now; // El check-in también cuenta como entrada
//     if (ticket.checkinAt == null) {
//       ticket.checkinAt = now;
//     }
//     await TicketDatabase.instance.updateTicket(ticket);
//     print("Check-in realizado: $now");
//   }
//   else {
//     print("la persona ya ingreso");
//   }
//   // Registrar el check-in solo si no se ha registrado antes
// }



// Future<void> checkIn(int ticketId) async {
//   // Buscar el ticket en la base de datos
//   final ticket = await TicketDatabase.instance.getTicket(ticketId);

//   if (ticket == null) {
//     // Si no se encuentra el ticket
//     print("No se encuentra ticketId: $ticketId");
//     return;
//   }

//   // Verificar si el último registro de entrada es nulo o si la última salida es posterior a la última entrada
//   bool puedeIngresar = ticket.lastEntryAt == null ||
//       (ticket.lastExitAt != null && ticket.lastExitAt!.compareTo(ticket.lastEntryAt!) > 0);

//   if (!puedeIngresar) {
//     print("La persona ya ingresó");
//     return;
//   }

//   if (!CHECKIN_AVAILABLE) {
//     print("Este dispositivo tiene desactivadas las entradas");
//     return;
//   }

//   // Registrar la nueva entrada
//   final now = DateTime.now().toIso8601String();
//   ticket.lastEntryAt = now;

//   // Si nunca se ha registrado un check-in, lo registramos ahora
//   if (ticket.checkinAt == null) {
//     ticket.checkinAt = now;
//   }

//   // Actualizar el ticket en la base de datos
//   await TicketDatabase.instance.updateTicket(ticket);
//   print("Check-in realizado: $now");
// }






// Future<void> registerEntry(int ticketId) async {
//   final ticket = await TicketDatabase.instance.getTicket(ticketId);
//   if (ticket != null) {
//     final now = DateTime.now().toIso8601String();
//     ticket.lastEntryAt = now;

//     await TicketDatabase.instance.updateTicket(ticket);
//     print("Entrada registrada: $now");
//   }
// }

// Future<void> registerExit(int ticketId) async {
//   final ticket = await TicketDatabase.instance.getTicket(ticketId);
//   if (ticket != null) {
//     final now = DateTime.now().toIso8601String();
//     ticket.lastExitAt = now;

//     await TicketDatabase.instance.updateTicket(ticket);
//     print("Salida registrada: $now");
//   }
// }
