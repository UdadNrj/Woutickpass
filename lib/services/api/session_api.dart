import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/models/objects/session.dart';

class SessionAPI {
  static const String _sessionBaseUrl =
      'https://api-dev.woutick.com/wpass/v1/session/';
  static const String _sessionWpassUrl =
      'https://api-dev.woutick.com/wpass/v1/session/';

  // Método para obtener detalles de sesión por UUID
  static Future<List<SessionDetails>> getSessionByUuid(String uuid) async {
    if (uuid.isEmpty) {
      throw Exception('Hace falta un UUID');
    }

    final String url = '$_sessionBaseUrl$uuid';
    return await _getSessionDetails(url);
  }

  // Método para obtener la lista de sesiones por código wpass
  static Future<List<Session>> getSessionsListByWpass(String wpass) async {
    if (wpass.isEmpty) {
      throw Exception('El código wpass está vacío al obtener eventos');
    }

    final String url = '$_sessionWpassUrl?wpass_code=$wpass';
    return await _getSessionsList(url);
  }

  // Método común para obtener detalles de sesión
  static Future<List<SessionDetails>> _getSessionDetails(String url) async {
    final headers = {'Content-Type': 'application/json'};
    debugPrint('Sending GET request to URL: $url');

    final http.Client client = http.Client();
    try {
      final response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return compute(_parseSessionDetails, response.body);
      } else {
        throw Exception(
            'Error al obtener detalles de la sesión. Código de estado: ${response.statusCode}. Cuerpo de la respuesta: ${response.body}');
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
      debugPrint('Error al obtener detalles de la sesión: $e');
      throw Exception('Error al obtener detalles de la sesión: $e');
    } finally {
      client.close();
    }
  }

  // Método común para obtener lista de sesiones
  static Future<List<Session>> _getSessionsList(String url) async {
    final headers = {'Content-Type': 'application/json'};
    debugPrint('Sending GET request to URL: $url');

    final http.Client client = http.Client();
    try {
      final response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return await compute(_parseSessionsList, response.body);
      } else {
        throw Exception(
            'Error al obtener la lista de sesiones. Código de estado: ${response.statusCode}. Cuerpo de la respuesta: ${response.body}');
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
      debugPrint('Error al obtener la lista de sesiones: $e');
      throw Exception('Error al obtener la lista de sesiones: $e');
    } finally {
      client.close();
    }
  }

  // Método privado para analizar detalles de sesión
  static List<SessionDetails> _parseSessionDetails(String responseBody) {
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
          'Se esperaba una lista de detalles de sesión pero se encontró: $jsonResponse');
    }
  }

  // Método privado para analizar lista de sesiones
  static List<Session> _parseSessionsList(String responseBody) {
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
