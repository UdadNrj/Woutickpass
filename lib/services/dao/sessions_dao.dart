import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/services/database.dart';

class SessionsDAO {
  Future<void> addSession(Session session) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'sessions',
      session.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeSession(String uuid) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      'sessions',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<void> clearSessions() async {
    final db = await DatabaseHelper().database;
    await db.delete('sessions');
  }

  Future<Session?> getSessionById(String uuid) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sessions',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );

    if (maps.isNotEmpty) {
      return Session.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Session>> getSelectedSessions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sessions',
      where: 'is_selected = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return Session.fromJson(maps[i]);
    });
  }

  Future<void> storeSessions(List<Session> sessions) async {
    final db = await DatabaseHelper().database;
    await db.delete('sessions');
    for (var session in sessions) {
      await db.insert(
        'sessions',
        session.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Session>> retrieveSessions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('sessions');
    return List.generate(maps.length, (i) {
      return Session.fromJson(maps[i]);
    });
  }

  Future<void> updateSelectedSessions(List<String> sessionUuids) async {
    final db = await DatabaseHelper().database;

    await db.update(
      'sessions',
      {'is_selected': 0},
    );

    for (var uuid in sessionUuids) {
      await db.update(
        'sessions',
        {'is_selected': 1},
        where: 'uuid = ?',
        whereArgs: [uuid],
      );
    }
  }

  Future<void> addSessionToSelectedSessions(String uuid) async {
    final db = await DatabaseHelper().database;
    await db.update(
      'sessions',
      {'is_selected': 1},
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<void> removeSessionFromSelectedSessions(String uuid) async {
    final db = await DatabaseHelper().database;
    await db.update(
      'sessions',
      {'is_selected': 0},
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<void> clearSelectedSessions() async {
    final db = await DatabaseHelper().database;
    await db.update(
      'sessions',
      {'is_selected': 0},
    );
  }
}
