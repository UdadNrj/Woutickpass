// // apiGetTickets(bolean only_new),
// // apiGetTicketDetails(),
// // apiDownloadTickets(bolean only_new),
// // apiDownloadTickets(),
// Class ticketService(get),

// lib/api/api_tickets.dart

// lib/services/api/api_ticket.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/services/tickets_dao.dart';

class ApiTickets {
  static Future<void> getSessionsBYTickets(String? sessionId) async {
    if (sessionId == null || sessionId.isEmpty) {
      throw Exception('El UUID de la sesión está vacío');
    }

    final dao = TicketsDao.instance;
    bool ticketsExist = await dao.sessionTicketsExist(sessionId);

    if (ticketsExist) {
      debugPrint(
          'Tickets for session $sessionId already exist. Skipping download.');
      return;
    }

    final headers = {
      'Content-Type': 'application/json',
    };

    debugPrint(
        'Sending GET request to URL: https://api-dev.woutick.com/wpass/v1/tickets/?session=$sessionId');

    final http.Client client = http.Client();
    try {
      final response = await client
          .get(
            Uri.parse(
                'https://api-dev.woutick.com/wpass/v1/tickets/?session=$sessionId'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          List<dynamic> ticketsJson =
              await compute(_parseTickets, response.body);
          List<Ticket> tickets =
              ticketsJson.map((json) => Ticket.fromMap(json)).toList();
          await _storeTickets(tickets);
        } else {
          throw Exception('El cuerpo de la respuesta está vacío.');
        }
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
    final List<dynamic> jsonResponse = json.decode(responseBody);
    if (jsonResponse is List) {
      return jsonResponse;
    } else {
      throw Exception(
          'Se esperaba una lista de entradas pero se encontró: $jsonResponse');
    }
  }

  static Future<void> _storeTickets(List<Ticket> tickets) async {
    final dao = TicketsDao.instance;
    for (var ticket in tickets) {
      await dao.insert(ticket);
    }
  }
}
