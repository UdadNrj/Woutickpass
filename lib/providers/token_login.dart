import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woutickpass/models/events_objeto..dart';

class TokenProvider with ChangeNotifier {
  String _token = '';
  List<Event> _selectedEvents = [];

  String get token => _token;
  List<Event> get selectedEvents => _selectedEvents;

  TokenProvider() {
    _loadToken();
    _loadSelectedEvents();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    notifyListeners();
  }

  Future<void> _loadSelectedEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventsJson = prefs.getStringList('selectedEvents') ?? [];
    _selectedEvents = eventsJson.map((json) {
      final eventMap = Map<String, dynamic>.from(jsonDecode(json));
      return Event.fromJson(eventMap);
    }).toList();
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    _selectedEvents.add(event);
    final prefs = await SharedPreferences.getInstance();
    final eventsJson =
        _selectedEvents.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('selectedEvents', eventsJson);
    notifyListeners();
  }

  Future<void> removeEvent(Event event) async {
    _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
    final prefs = await SharedPreferences.getInstance();
    final eventsJson =
        _selectedEvents.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('selectedEvents', eventsJson);
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('selectedEvents');
    _selectedEvents.clear();
    notifyListeners();
  }
}
// import 'package:flutter/material.dart';

// class TokenProvider with ChangeNotifier {
//   String _token = "";

//   String get token => _token;

//   void change(String newToken) {
//     _token = newToken;
//     notifyListeners(); // Asegúrate de notificar a los listeners
//   }
// }
