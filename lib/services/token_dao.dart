import 'package:sqflite/sqflite.dart';

import 'package:woutickpass/services/database.dart';



class TokenDao {
  Future<void> insertToken(String token) async {
    final db = await DatabaseHelper().database;
    await db.insert('token', {'token': token}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> retrieveToken() async {
    final db = await DatabaseHelper().database;
    final result = await db.query('token');
    if (result.isNotEmpty) {
      return result.first['token'] as String?;
    }
    return null;
  }

  Future<void> deleteToken() async {
    final db = await DatabaseHelper().database;
    await db.delete('token');
  }
}
