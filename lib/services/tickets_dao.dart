import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/services/database.dart';

class TicketsDao {
  Future<void> createTicket(Map<String, dynamic> ticket) async {
    final db = await DatabaseHelper().database;
    await db.insert('tickets', ticket);
  }

  Future<Map<String, dynamic>?> readTicket(String uuid) async {
    final db = await DatabaseHelper().database;
    final maps = await db.query(
      'tickets',
      columns: ['*'],
      where: 'uuid = ?',
      whereArgs: [uuid],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> readAllTickets() async {
    final db = await DatabaseHelper().database;
    return await db.query('tickets');
  }

  Future<int> updateTicket(Map<String, dynamic> ticket) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'tickets',
      ticket,
      where: 'uuid = ?',
      whereArgs: [ticket['uuid']],
    );
  }

  Future<int> deleteTicket(String uuid) async {
    final db = await DatabaseHelper().database;
    return await db.delete(
      'tickets',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<Map<String, int>> getTicketStatistics() async {
    final db = await DatabaseHelper().database;
    final stats = {
      'total': Sqflite.firstIntValue(
              await db.rawQuery('SELECT COUNT(uuid) FROM tickets')) ??
          0,
      'inside': Sqflite.firstIntValue(await db.rawQuery(
              'SELECT COUNT(uuid) FROM tickets WHERE last_entry_at IS NOT NULL AND last_exit_at IS NULL')) ??
          0,
      'outside': Sqflite.firstIntValue(await db.rawQuery(
              'SELECT COUNT(uuid) FROM tickets WHERE last_exit_at IS NOT NULL')) ??
          0,
      'unread': Sqflite.firstIntValue(await db.rawQuery(
              'SELECT COUNT(uuid) FROM tickets WHERE accessed_at IS NULL')) ??
          0,
    };
    return stats;
  }

  Future<Map<String, int>> getTicketTypeCounts() async {
    final db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> types = await db.rawQuery(
        'SELECT ticket, COUNT(*) as count FROM tickets GROUP BY ticket');
    return {
      for (var row in types) row['ticket'] as String: row['count'] as int,
    };
  }

  Future<List<Map<String, dynamic>>> searchAttendees(String query) async {
    final db = await DatabaseHelper().database;
    return await db.query(
      'tickets',
      where: 'name LIKE ? OR dni LIKE ? OR email LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
  }

  Future<Map<String, dynamic>?> getTicketDetails(String uuid) async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'tickets',
      columns: [
        'codigo_de_entrada',
        'fecha_de_compra',
        'tipo_de_entrada',
        'precio'
      ],
      where: 'uuid = ?',
      whereArgs: [uuid],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<String>> getTicketTypes() async {
    final db = await DatabaseHelper().database;
    final result =
        await db.rawQuery('SELECT DISTINCT tipo_de_entrada FROM tickets');
    return result.map((row) => row['tipo_de_entrada'] as String).toList();
  }
}
