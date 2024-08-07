import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/services/dao/sessions_dao.dart';

class AuthSessionAPI {
  static const String _baseUrl =
      'https://api-dev.woutick.com/back/v1/session/get-wpass/';

  // Método para obtener sesiones
  static Future<List<Session>> getSession(String token) async {
    if (token.isEmpty) {
      throw Exception('El token está vacío al obtener sesiones');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(_baseUrl), headers: headers);

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          return jsonResponse
              .map<Session>((json) => Session.fromJson(json))
              .toList();
        } else {
          throw Exception(
              'Se esperaba una lista de sesiones pero se encontró: $jsonResponse');
        }
      } else {
        throw Exception(
            'No se pudieron cargar las sesiones. Código de estado: ${response.statusCode}. Cuerpo de la respuesta: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error al obtener sesiones: $e');
      throw Exception('No se pudieron cargar las sesiones. Error: $e');
    }
  }

  // Método para actualizar sesiones
  static Future<void> updateSessions(String token) async {
    final sessions = await getSession(token);
    final dbHelper = SessionsDAO();
    await dbHelper.storeSessions(sessions);
    debugPrint('Sesiones actualizadas correctamente.');
  }

  // Método para obtener y almacenar sesiones
  static Future<void> fetchAndStoreSessions(String token) async {
    final sessions = await getSession(token);
    final dbHelper = SessionsDAO();
    await dbHelper.storeSessions(sessions);
    debugPrint('Sesiones obtenidas y almacenadas correctamente.');
  }

  // Método para obtener y actualizar sesiones seleccionadas
  static Future<void> fetchAndUpdateSelectedSessions(String token) async {
    final sessions = await getSession(token);
    final dbHelper = SessionsDAO();
    final selectedSessions = await dbHelper.getSelectedSessions();

    final selectedUuids =
        selectedSessions.map((session) => session.uuid).toList();
    final filteredSessions = sessions
        .where((session) => selectedUuids.contains(session.uuid))
        .toList();

    await dbHelper.storeSessions(filteredSessions);
    debugPrint('Sesiones seleccionadas actualizadas correctamente.');
  }
}
