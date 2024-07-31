import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:woutickpass/services/sessions_dao.dart';
import 'package:woutickpass/models/objects/session.dart';

class EventService {
  static Future<List<Session>> getEvents(String token) async {
    if (token.isEmpty) {
      throw Exception('El token está vacío al obtener eventos');
    }
    const String url = 'https://api-dev.woutick.com/back/v1/session/get-wpass/';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response.body);
        } catch (e) {
          throw Exception('Failed to decode JSON: $e');
        }

        debugPrint('Decoded JSON: $jsonResponse');

        if (jsonResponse is List) {
          return jsonResponse.map((json) => Session.fromJson(json)).toList();
        } else {
          throw Exception('Expected a list of events but found: $jsonResponse');
        }
      } else {
        throw Exception(
            'Failed to load events. Status code: ${response.statusCode}. Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to load events. Error: $e');
    }
  }

  static Future<void> uapdteEvents(String token) async {
    print('Updating events with token: $token');
    if (token.isEmpty) {
      throw Exception('El token está vacío al actualizar eventos');
    }
    final events = await getEvents(token);
    final dbHelper = SessionsDao();

    await dbHelper.storeSessions(events);

    debugPrint('Events have been updated.');
  }

  static Future<void> fetchAndStoreEvents(String token) async {
    print('Fetching and storing events with token: $token');
    if (token.isEmpty) {
      throw Exception('El token está vacío al obtener y almacenar eventos');
    }
    final events = await getEvents(token);
    final dbHelper = SessionsDao();

    await dbHelper.storeSessions(events);

    debugPrint('Events have been fetched and stored.');
  }

  static Future<void> fetchAndUpdateSelectedEvents(String token) async {
    print('Fetching and updating selected events with token: $token');
    if (token.isEmpty) {
      throw Exception(
          'El token está vacío al obtener y actualizar eventos seleccionados');
    }
    final events = await getEvents(token);
    final dbHelper = SessionsDao();
    final selectedEvents = await dbHelper.getSelectedSessions();

    final selectedUuids = selectedEvents.map((event) => event.uuid).toList();
    final filteredEvents =
        events.where((event) => selectedUuids.contains(event.uuid)).toList();

    await dbHelper.storeSessions(filteredEvents);

    debugPrint('Selected events have been updated.');
  }
}
