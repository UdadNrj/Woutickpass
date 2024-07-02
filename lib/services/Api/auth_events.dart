// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:woutickpass/src/widgets/custom_Events.dart';

// class EventService {
//   static Future<List<EventS>> getEvents(String token) async {
//     const String url = "https://api-dev.woutick.com/back/v1/event/";
//     try {
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
//       final response = await http.get(
//         Uri.parse(url),
//         headers: headers,
//       );

//       debugPrint('Response status: ${response.statusCode}');
//       debugPrint('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         Map<String, dynamic> jsonResponse;
//         try {
//           jsonResponse = json.decode(response.body);
//         } catch (e) {
//           throw Exception('Failed to decode JSON: $e');
//         }

//         debugPrint('Decoded JSON: $jsonResponse');

//         if (jsonResponse.containsKey('results')) {
//           var eventsData = jsonResponse['results'];
//           if (eventsData is List) {
//             List<EventS> events =
//                 eventsData.map((json) => EventS.fromJson(json)).toList();
//             return events;
//           } else {
//             throw Exception('Expected a list of events but found: $eventsData');
//           }
//         } else {
//           throw Exception(
//               'Key "results" not found in the response. Full response: $jsonResponse');
//         }
//       } else {
//         throw Exception(
//             'Failed to load events. Status code: ${response.statusCode}. Response body: ${response.body}');
//       }
//     } catch (e) {
//       debugPrint('Error: $e');
//       throw Exception('Failed to load events. Error: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:woutickpass/models/events_objeto..dart';

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
}
