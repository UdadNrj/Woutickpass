import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/services/database.dart';

class SessionDetailsDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertSessionDetails(SessionDetails sessionDetails) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'session_details',
      sessionDetails.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<SessionDetails?> getSessionDetails(String uuid) async {
    final db = await _databaseHelper.database;
    final maps = await db.query(
      'session_details',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );

    if (maps.isNotEmpty) {
      return SessionDetails.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<SessionDetails>> getAllSessionDetails() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('session_details');

    return List.generate(maps.length, (i) {
      return SessionDetails.fromMap(maps[i]);
    });
  }

  Future<void> updateSessionDetails(SessionDetails sessionDetails) async {
    final db = await _databaseHelper.database;
    await db.update(
      'session_details',
      sessionDetails.toMap(),
      where: 'uuid = ?',
      whereArgs: [sessionDetails.uuid],
    );
  }

  Future<void> deleteSessionDetails(String uuid) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'session_details',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<void> deleteAllSessionDetails() async {
    final db = await _databaseHelper.database;
    await db.delete('session_details');
  }
}
