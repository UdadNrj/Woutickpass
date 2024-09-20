import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/services/dao/comercial_dao.dart';
import 'package:woutickpass/services/database.dart';

class SessionsDAO {
  bool _isDatabaseBusy = false; // Flag para evitar accesos simultáneos

  // Método genérico para manejar el flag de base de datos ocupada
  Future<void> _runDatabaseOperation(Future<void> Function() operation) async {
    if (_isDatabaseBusy) {
      print("La base de datos ya está ocupada. Esperando...");
      return;
    }

    _isDatabaseBusy = true;
    try {
      await operation();
    } catch (e) {
      print("Error en operación de base de datos: $e");
    } finally {
      _isDatabaseBusy = false;
    }
  }

  Future<T> _runDatabaseQuery<T>(Future<T> Function() operation) async {
    if (_isDatabaseBusy) {
      print("La base de datos ya está ocupada. Esperando...");
      return Future.error("Database busy");
    }

    _isDatabaseBusy = true;
    try {
      return await operation();
    } catch (e) {
      print("Error en consulta de base de datos: $e");
      return Future.error(
          e); // Aseguramos que el error se propague correctamente
    } finally {
      _isDatabaseBusy = false;
    }
  }

  Future<void> addSession(Session session) async {
    await _runDatabaseOperation(() async {
      final db = await DatabaseHelper().database;
      try {
        await db.transaction((txn) async {
          await txn.insert(
            'sessions',
            session.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
        print("Sesión añadida: ${session.uuid}");
      } catch (e) {
        print("Error al añadir la sesión ${session.uuid}: $e");
      }
    });
  }

  Future<void> removeSession(String uuid) async {
    await _runDatabaseOperation(() async {
      final db = await DatabaseHelper().database;
      try {
        await db.transaction((txn) async {
          await txn.delete('sessions', where: 'uuid = ?', whereArgs: [uuid]);
        });
        print("Sesión eliminada: $uuid");
      } catch (e) {
        print("Error al eliminar la sesión $uuid: $e");
      }
    });
  }

  Future<List<Session>> getSelectedSessions() async {
    return await _runDatabaseQuery<List<Session>>(() async {
      final db = await DatabaseHelper().database;
      try {
        final List<Map<String, dynamic>> maps = await db.query(
          'sessions',
          where: 'is_selected = ?',
          whereArgs: [1],
        );

        return maps.map((map) => Session.fromJson(map)).toList();
      } catch (e) {
        print("Error al obtener las sesiones seleccionadas: $e");
        return [];
      }
    });
  }

  Future<List<Session>> retrieveSessions() async {
    return await _runDatabaseQuery<List<Session>>(() async {
      final db = await DatabaseHelper().database;
      try {
        final List<Map<String, dynamic>> maps = await db.query('sessions');
        return maps.map((map) => Session.fromJson(map)).toList();
      } catch (e) {
        print("Error al recuperar las sesiones: $e");
        return [];
      }
    });
  }

  Future<void> clearSessions() async {
    await _runDatabaseOperation(() async {
      final db = await DatabaseHelper().database;
      try {
        await db.transaction((txn) async {
          await txn.delete('sessions');
        });
        print("Todas las sesiones han sido eliminadas");
      } catch (e) {
        print("Error al limpiar las sesiones: $e");
      }
    });
  }

  Future<SessionDetails?> getSessionById(String sessionId) async {
    final db = await DatabaseHelper().database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'sessions',
        where: 'uuid = ?',
        whereArgs: [sessionId],
      );

      if (maps.isNotEmpty) {
        return SessionDetails.fromJson(
            maps.first); // Cambiar para retornar SessionDetails
      } else {
        return null;
      }
    } catch (e) {
      print("Error al obtener la sesión $sessionId: $e");
      return null;
    }
  }

  Future<void> _storeSessionDetails(SessionDetails sessionDetails) async {
    final db = await DatabaseHelper().database;
    try {
      await db.transaction((txn) async {
        // Almacena los detalles de la sesión dentro de la transacción
        await SessionsDAO().storeSessions([sessionDetails], txn);

        // Almacena los comerciales relacionados dentro de la misma transacción
        for (var commercial in sessionDetails.commercials) {
          await CommercialsDAO().storeCommercial(commercial, txn);
        }
      });

      print(
          'Session details and commercials stored for session ${sessionDetails.uuid}');
    } catch (e) {
      print('Error storing session details: $e');
    }
  }

  Future<void> storeSessions(
      List<SessionDetails> sessionDetailsList, Transaction txn) async {
    try {
      for (var sessionDetails in sessionDetailsList) {
        // Inserta los detalles de la sesión en la tabla 'sessions' usando la transacción
        await txn.insert(
          'sessions',
          sessionDetails.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      print("Sesiones almacenadas exitosamente");
    } catch (e) {
      print("Error al almacenar las sesiones: $e");
    }
  }

  Future<void> updateSelectedSessions(List<String> sessionUuids) async {
    await _runDatabaseOperation(() async {
      final db = await DatabaseHelper().database;
      try {
        await db.transaction((txn) async {
          await txn.update('sessions', {'is_selected': 0});
          for (var uuid in sessionUuids) {
            await txn.update(
              'sessions',
              {'is_selected': 1},
              where: 'uuid = ?',
              whereArgs: [uuid],
            );
          }
        });
        print("Sesiones seleccionadas actualizadas");
      } catch (e) {
        print("Error al actualizar las sesiones seleccionadas: $e");
      }
    });
  }

  Future<void> addSessionToSelectedSessions(String uuid) async {
    final db = await DatabaseHelper().database;
    try {
      await db.update(
        'sessions',
        {'is_selected': 1},
        where: 'uuid = ?',
        whereArgs: [uuid],
      );
      print("Sesión $uuid añadida a las sesiones seleccionadas");
    } catch (e) {
      print("Error al añadir la sesión $uuid a las sesiones seleccionadas: $e");
    }
  }

  Future<void> removeSessionFromSelectedSessions(String uuid) async {
    final db = await DatabaseHelper().database;
    try {
      await db.update(
        'sessions',
        {'is_selected': 0},
        where: 'uuid = ?',
        whereArgs: [uuid],
      );
      print("Sesión $uuid removida de las sesiones seleccionadas");
    } catch (e) {
      print(
          "Error al remover la sesión $uuid de las sesiones seleccionadas: $e");
    }
  }

  Future<void> clearSelectedSessions() async {
    final db = await DatabaseHelper().database;
    try {
      await db.update('sessions', {'is_selected': 0});
      print("Todas las sesiones seleccionadas han sido deseleccionadas");
    } catch (e) {
      print("Error al limpiar las sesiones seleccionadas: $e");
    }
  }
}
