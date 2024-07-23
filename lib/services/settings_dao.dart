import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/services/database.dart';

class SettingsDao {
  Future<void> saveSetting(String key, bool value) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'settings',
      {'key': key, 'value': value ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> loadSetting(String key, bool defaultValue) async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (result.isNotEmpty) {
      return result.first['value'] == 1;
    }
    return defaultValue;
  }

  Future<void> deleteSetting(String key) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
  }

  Future<void> logout() async {
    final db = await DatabaseHelper().database;
    await db.delete('settings');
  }
}
