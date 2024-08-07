import 'package:sqflite/sql.dart';
import 'package:woutickpass/services/database.dart';

class TokenDAO {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertToken(String token) async {
    if (token.isEmpty) {
      throw Exception('El token no puede ser vacío');
    }
    final db = await _databaseHelper.database;
    await db.insert(
      'token',
      {'token': token},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> retrieveToken() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('token', limit: 1);

    if (maps.isNotEmpty) {
      return maps.first['token'] as String?;
    }
    return null;
  }

  Future<void> deleteToken() async {
    final db = await _databaseHelper.database;
    await db.delete('token');
  }
}
