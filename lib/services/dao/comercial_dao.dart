import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/services/database.dart';

class CommercialsDAO {
  // Método para almacenar un comercial con transacción
  Future<void> storeCommercial(Commercial commercial, Transaction? txn) async {
    try {
      if (txn != null) {
        // Inserta el comercial en la tabla 'commercials' usando la transacción
        await txn.insert(
          'commercials',
          commercial.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        // Si no se pasa transacción, usa el método regular de base de datos
        final db = await DatabaseHelper().database;
        await db.insert(
          'commercials',
          commercial.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      print("Comercial almacenado exitosamente: ${commercial.uuid}");
    } catch (e) {
      print("Error al almacenar el comercial: $e");
    }
  }

  Future<List<Commercial>> getCommercialsBySession(String sessionUuid) async {
    final db = await DatabaseHelper().database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'commercials',
        where:
            'session_uuid = ?', // Asegúrate de que esta columna existe en la tabla
        whereArgs: [sessionUuid],
      );

      if (maps.isEmpty) {
        print("No se encontraron comerciales para la sesión $sessionUuid");
      }

      return maps.map((map) => Commercial.fromMap(map)).toList();
    } catch (e) {
      print("Error al recuperar comerciales para la sesión $sessionUuid: $e");
      return [];
    }
  }

  // Método para actualizar un comercial
  Future<void> updateCommercial(Commercial commercial) async {
    final db = await DatabaseHelper().database;
    try {
      await db.update(
        'commercials',
        commercial.toMap(),
        where: 'uuid = ?',
        whereArgs: [commercial.uuid],
      );
      print("Comercial actualizado exitosamente: ${commercial.uuid}");
    } catch (e) {
      print("Error al actualizar el comercial: $e");
    }
  }

  // Método para eliminar un comercial por su uuid
  Future<void> deleteCommercial(String commercialUuid) async {
    final db = await DatabaseHelper().database;
    try {
      await db.delete(
        'commercials',
        where: 'uuid = ?',
        whereArgs: [commercialUuid],
      );
      print("Comercial eliminado exitosamente: $commercialUuid");
    } catch (e) {
      print("Error al eliminar el comercial: $e");
    }
  }

  // Método para obtener todos los comerciales sin filtrar por sesión
  Future<List<Commercial>> getAllCommercials() async {
    final db = await DatabaseHelper().database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('commercials');
      return maps.map((map) => Commercial.fromMap(map)).toList();
    } catch (e) {
      print("Error al recuperar todos los comerciales: $e");
      return [];
    }
  }
}
