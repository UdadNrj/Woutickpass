import 'package:sqflite/sqflite.dart';

import 'package:woutickpass/services/database.dart';
import 'package:woutickpass/models/Sessions_objeto..dart';

class SessionsDao {
  Future<void> addSession(Sessions session) async {
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

  Future<List<Sessions>> getSelectedSessions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sessions',
      where: 'is_selected = 1',
    );
    return List.generate(maps.length, (i) {
      return Sessions.fromJson(maps[i]);
    });
  }

  Future<void> storeSessions(List<Sessions> sessions) async {
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

  Future<List<Sessions>> retrieveSessions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('sessions');
    return List.generate(maps.length, (i) {
      return Sessions.fromJson(maps[i]);
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
