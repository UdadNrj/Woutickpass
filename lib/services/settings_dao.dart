import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/services/database.dart';

class SettingDao {
  final DatabaseHelper _dbHelper;

  SettingDao(this._dbHelper);

  Future<bool> loadSetting(String key, bool defaultValue) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );

    if (maps.isNotEmpty) {
      return maps.first['value'] == 1;
    } else {
      return defaultValue;
    }
  }

  Future<void> saveSetting(String key, bool value) async {
    try {
      final db = await _dbHelper.database;

      await db.insert(
        'settings',
        {'key': key, 'value': value ? 1 : 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error al guardar la configuración: $e');
    }
  }

  Future<void> logout() async {
    final db = await _dbHelper.database;

    await db.delete('settings');
  }
}
