import 'package:sqflite/sqflite.dart';
import 'package:woutickpass/services/database.dart';

class SettingDAO {
  final DatabaseHelper _dbHelper;

  SettingDAO(this._dbHelper);

  /// Carga un ajuste dado su clave [key], devuelve [defaultValue] si no se encuentra
  Future<bool> loadSetting(String key, bool defaultValue) async {
    try {
      final db = await _dbHelper.database;

      // Consulta en la tabla de settings por la clave específica
      final List<Map<String, dynamic>> maps = await db.query(
        'settings',
        where: 'setting_key = ?',
        whereArgs: [key],
      );

      // Si existe un valor para esa clave, devuelve su estado booleano
      if (maps.isNotEmpty) {
        return maps.first['setting_value'] == 1; // true si es 1, false si es 0
      } else {
        return defaultValue;
      }
    } catch (e) {
      print('Error al cargar el ajuste: $e');
      return defaultValue;
    }
  }

  /// Guarda un ajuste dado su clave [key] y valor booleano [value]
  Future<void> saveSetting(String key, bool value) async {
    try {
      final db = await _dbHelper.database;

      // Inserta o reemplaza el valor de setting si ya existe
      await db.insert(
        'settings',
        {
          'setting_key': key,
          'setting_value': value ? 1 : 0, // Almacena 1 para true, 0 para false
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // Reemplaza si ya existe
      );
    } catch (e) {
      print('Error al guardar la configuración: $e');
    }
  }

  /// Obtiene el valor entero (0 o 1) de un ajuste dado su clave [key]
  Future<int> getSetting(String key) async {
    try {
      final db = await _dbHelper.database;

      // Consulta el valor de setting
      final List<Map<String, dynamic>> maps = await db.query(
        'settings',
        where: 'setting_key = ?',
        whereArgs: [key],
      );

      // Si existe, devuelve el valor, de lo contrario, retorna 0 por defecto
      if (maps.isNotEmpty) {
        return maps.first['setting_value'] as int;
      } else {
        return 0; // Valor por defecto
      }
    } catch (e) {
      print('Error al obtener la configuración: $e');
      return 0;
    }
  }
}
