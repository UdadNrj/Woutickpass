import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/session.dart';

class ApiAuthWpass {
  static Future<List<Session>> getSessions(String wpass) async {
    if (wpass.isEmpty) {
      throw Exception('El código wpass está vacío al obtener eventos');
    }
    final headers = {
      'Content-Type': 'application/json',
    };

    debugPrint('Sending GET request to URL: ');

    final http.Client client = http.Client();
    try {
      final response = await client
          .get(
            Uri.parse(
                'https://api-dev.woutick.com/wpass/v1/session/?wpass_code=$wpass'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return await compute(_parseSessions, response.body);
      } else {
        throw Exception(
            'Error al obtener eventos. Código de estado: ${response.statusCode}. Cuerpo de la respuesta: ${response.body}');
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
      debugPrint('Error al obtener sesiones: $e');
      throw Exception('Error al obtener sesiones: $e');
    } finally {
      client.close();
    }
  }

  static List<Session> _parseSessions(String responseBody) {
    final List<dynamic> jsonResponse = json.decode(responseBody);
    if (jsonResponse is List) {
      return jsonResponse.map((json) {
        if (json is Map<String, dynamic>) {
          return Session.fromJson(json);
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
