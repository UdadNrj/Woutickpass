import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/services/sessions_details_dao.dart';

class ApiAuthUuid {
  static const String baseUrl =
      'https://api-dev.woutick.com/wpass/v1/session/f0c95787-5116-488a-b0d8-847cf217590f/';

  static Future<List<SessionDetails>> getSessionsByUUIDs(
      List<String> uuids) async {
    if (uuids.isEmpty) {
      throw Exception('La lista de UUIDs está vacía');
    }

    final String url = _constructUrl(uuids);
    final headers = {
      'Content-Type': 'application/json',
    };

    debugPrint('Sending GET request to URL: $url');

    final http.Client client = http.Client();
    try {
      final response = await client
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<SessionDetails> sessions =
            await compute(parseSessions, response.body);

        await _saveSessionsToDatabase(sessions);

        return sessions;
      } else {
        throw Exception(
            'Error al obtener las sesiones. Código de estado: ${response.statusCode}. Cuerpo de la respuesta: ${response.body}');
      }
    } on SocketException {
      throw Exception(
          'No se pudo conectar al servidor. Verifica tu conexión a Internet.');
    } on TimeoutException {
      throw Exception(
          'La solicitud al servidor ha excedido el tiempo de espera.');
    } on FormatException {
      throw Exception('Formato de respuesta no válido.');
    } catch (e) {
      debugPrint('Error al obtener las sesiones: $e');
      throw Exception('Error al obtener las sesiones: $e');
    } finally {
      client.close();
    }
  }

  static String _constructUrl(List<String> uuids) {
    final uuidString = uuids.join(',');
    return '$baseUrl/sessions/?uuids=$uuidString';
  }

  static List<SessionDetails> parseSessions(String responseBody) {
    final List<dynamic> jsonResponse = json.decode(responseBody);
    if (jsonResponse is List) {
      return jsonResponse.map((json) {
        if (json is Map<String, dynamic>) {
          return SessionDetails.fromJson(json);
        } else {
          throw Exception('Elemento en la lista no es un mapa: $json');
        }
      }).toList();
    } else {
      throw Exception(
          'Se esperaba una lista de sesiones pero se encontró: $jsonResponse');
    }
  }

  static Future<void> _saveSessionsToDatabase(
      List<SessionDetails> sessions) async {
    final sessionDetailsDao = SessionDetailsDao();

    for (var session in sessions) {
      try {
        await sessionDetailsDao.insertSessionDetails(session);
      } catch (e) {
        debugPrint('Error al insertar sesión en la base de datos: $e');
      }
    }
  }
}
