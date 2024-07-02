import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woutickpass/models/events_objeto..dart';

class EventDao {
  static const String _eventsKey = 'events';

  static Future<void> insertEvent(Event event) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> events = prefs.getStringList(_eventsKey) ?? [];
    events.add(jsonEncode(event.toJson()));
    await prefs.setStringList(_eventsKey, events);
  }

  static Future<List<Event>> retrieveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> events = prefs.getStringList(_eventsKey) ?? [];
    return events.map((e) => Event.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> deleteEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_eventsKey);
  }
}
