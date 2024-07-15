import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:woutickpass/models/events_objeto..dart';
import 'package:woutickpass/services/database.dart';

class EventService {
  static Future<List<Event>> getEvents(String token) async {
    const String url = 'https://api-dev.woutick.com/back/v1/session/get-wpass/';
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
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
          List<Event> events =
              jsonResponse.map((json) => Event.fromJson(json)).toList();
          return events;
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

  static Future<void> updateEvents(String token) async {
    final events = await getEvents(token);
    final dbHelper = DatabaseHelper();

    await dbHelper.storeEvents(events);

    debugPrint('Events have been updated.');
  }

  static Future<void> fetchAndStoreEvents(String token) async {
    final events = await getEvents(token);
    final dbHelper = DatabaseHelper();

    await dbHelper.storeEvents(events);

    debugPrint('Events have been fetched and stored.');
  }

  static Future<void> fetchAndUpdateSelectedEvents(String token) async {
    final events = await getEvents(token);
    final dbHelper = DatabaseHelper();
    final selectedUuids = await dbHelper.retrieveSelectedEvents(); // Obtener UUIDs de eventos seleccionados

    // Filtrar eventos seleccionados
    final selectedEvents = events.where((event) => selectedUuids.contains(event.uuid)).toList();

    // Actualizar eventos seleccionados en la base de datos
    await dbHelper.storeEvents(selectedEvents);

    debugPrint('Selected events have been updated.');
  }
}
