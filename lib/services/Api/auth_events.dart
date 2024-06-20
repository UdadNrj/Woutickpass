import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/custom_Events.dart';

class EventService {
  static Future<List<EventS>> getEvents(String token) async {
    const String url = "https://api-dev.woutick.com/back/v1/event/";
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        debugPrint('Response body: ${response.body}');

        List<EventS> events =
            jsonResponse.map((json) => EventS.fromJson(json)).toList();

        return events;
      } else {
        throw Exception(
            'Failed to load events. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(
          'Error: $e'); // Asegúrate de que debugPrint esté bien utilizado
      throw Exception('Failed to load events. Error: $e');
    }
  }
}
