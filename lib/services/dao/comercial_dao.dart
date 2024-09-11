import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/services/database.dart';

class CommercialDAO {
  Future<void> addCommercial(Commercial commercial) async {
    final db = await DatabaseHelper().database;
    try {
      await db.transaction((txn) async {
        await txn.insert(
          'commercials',
          commercial.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
      print("Commercial añadido: ${commercial.uuid}");
    } catch (e) {
      print("Error al añadir el commercial: $e");
    }
  }

  Future<void> removeCommercial(String uuid) async {
    final db = await DatabaseHelper().database;
    try {
      await db.transaction((txn) async {
        await txn.delete(
          'commercials',
          where: 'uuid = ?',
          whereArgs: [uuid],
        );
      });
      print("Commercial eliminado con UUID: $uuid");
    } catch (e) {
      print("Error al eliminar el commercial: $e");
    }
  }

  Future<void> storeCommercials(
      List<Commercial> commercials, String sessionUuid) async {
    final db = await DatabaseHelper().database;
    try {
      await db.transaction((txn) async {
        await txn.delete('commercials',
            where: 'session_uuid = ?', whereArgs: [sessionUuid]);
        for (var commercial in commercials) {
          await txn.insert(
            'commercials',
            commercial.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      print("Commercials guardados para la sesión $sessionUuid");
    } catch (e) {
      print("Error en storeCommercials para la sesión $sessionUuid: $e");
    }
  }

  Future<List<Commercial>> getCommercialsBySession(String sessionUuid) async {
    final db = await DatabaseHelper().database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'commercials',
        where: 'session_uuid = ?',
        whereArgs: [sessionUuid],
      );
      return maps.isNotEmpty
          ? maps.map((json) => Commercial.fromJson(json)).toList()
          : [];
    } catch (e) {
      print("Error al obtener commercials para la sesión $sessionUuid: $e");
      return [];
    }
  }

  // Método para obtener estadísticas de comerciales
  Future<Map<String, int>> getCommercialStatistics(String sessionUuid) async {
    final db = await DatabaseHelper().database;

    final result = await db.query(
      'commercials',
      where: 'session_uuid = ?',
      whereArgs: [sessionUuid],
    );

    Map<String, int> stats = {};
    for (var commercial in result) {
      // Casting explícito a String
      String name = (commercial['name'] as String?) ?? 'Unknown';
      if (stats.containsKey(name)) {
        stats[name] = stats[name]! + 1;
      } else {
        stats[name] = 1;
      }
    }

    return stats;
  }
}
