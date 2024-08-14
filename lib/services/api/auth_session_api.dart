import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';

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
}
