import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/session_details.dart';

class ApiAuthSessionUuid {
  static Future<List<SessionDetails>> getSessionsByUUIDs(
      List<String> uuids) async {
    if (uuids.isEmpty) {
      throw Exception('La lista de UUIDs está vacía');
    }
    final headers = {
      'Content-Type': 'application/json',
    };

    debugPrint('Sending GET request to URL:');

    final http.Client client = http.Client();
    try {
      final response = await client
          .get(
            Uri.parse(
                'https://api-dev.woutick.com/wpass/v1/session/?wpass_code=$uuids'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return await compute(_parseSessions, response.body);
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

  static List<SessionDetails> _parseSessions(String responseBody) {
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
}
