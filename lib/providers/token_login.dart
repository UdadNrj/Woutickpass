import 'package:flutter/material.dart';
import 'package:woutickpass/models/events_objeto..dart';
import 'package:woutickpass/services/database.dart';

class TokenProvider with ChangeNotifier {
  String _token = '';
  List<Event> _selectedEvents = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  String get token => _token;
  List<Event> get selectedEvents => _selectedEvents;

  TokenProvider() {
    _loadToken();
    _loadSelectedEvents();
  }

  Future<void> _loadToken() async {
    _token = await _dbHelper.retrieveToken() ?? '';
    notifyListeners();
  }

  Future<void> _loadSelectedEvents() async {
    _selectedEvents = await _dbHelper.getSelectedEvents();
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    await _dbHelper.insertToken(token);
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    _selectedEvents.add(event);
    await _dbHelper.addEvent(event);
    notifyListeners();
  }

  Future<void> removeEvent(Event event) async {
    _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
    await _dbHelper.removeEvent(event.uuid);
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = '';
    await _dbHelper.deleteToken();
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
