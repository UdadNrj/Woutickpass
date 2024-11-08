import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:woutickpass/models/objects/ticket_details.dart';

class TicketsAPI {
  static const String apiKey = 'GkL%2F+8}7E.3dKaC]PmxQz]am~#E#av_4,utP2Wg*hBq';

  static Future<List<TicketDetails>> getTicketsByUuid(String? uuid) async {
    return await _getTickets(
        'https://api-dev.woutick.com/wpass/v1/tickets/$uuid', uuid);
  }

  static Future<List<TicketDetails>> getTicketsBySessionUuid(
      String? sessionUuid) async {
    return await _getTickets(
        'https://api-dev.woutick.com/wpass/v1/tickets/?session=$sessionUuid',
        sessionUuid);
  }

  static Future<List<TicketDetails>> _getTickets(String url, String? id) async {
    if (id == null || id.isEmpty) {
      throw Exception('El UUID está vacío');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Api-Key': apiKey,
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
        if (response.body.isNotEmpty) {
          List<dynamic> ticketsJson =
              await compute(_parseTickets, response.body);
          List<TicketDetails> tickets =
              ticketsJson.map((json) => TicketDetails.fromMap(json)).toList();
          await _storeTickets(tickets);
          return tickets;
        } else {
          throw Exception('El cuerpo de la respuesta está vacío.');
        }
      } else if (response.statusCode == 404) {
        debugPrint('No tickets found for ID: $id. Skipping download.');
        return [];
      } else {
        throw Exception(
            'Error al obtener las entradas. Código de estado: ${response.statusCode}. Cuerpo de la respuesta: ${response.body}');
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
      debugPrint('Error al obtener las entradas: $e');
      throw Exception('Error al obtener las entradas: $e');
    } finally {
      client.close();
    }
  }

  static List<dynamic> _parseTickets(String responseBody) {
    final dynamic jsonResponse = json.decode(responseBody);

    if (jsonResponse is List) {
      return jsonResponse;
    } else if (jsonResponse is Map<String, dynamic>) {
      return [jsonResponse];
    } else {
      throw Exception('Unexpected format in tickets JSON list: $jsonResponse');
    }
  }

  static Future<void> _storeTickets(List<TicketDetails> tickets) async {
    // Aquí puedes implementar la lógica para almacenar las entradas en una base de datos o en cualquier otro lugar.
    // Por ejemplo, puedes usar otro DAO o cualquier otra lógica de almacenamiento.
    // Esta función es un placeholder y debe ser adaptada a tus necesidades.
    for (var ticket in tickets) {
      // Implementa tu lógica de almacenamiento aquí
      // await someStorageFunction(ticket);
    }
  }
}
