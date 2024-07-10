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
    try {
      _token = await _dbHelper.retrieveToken() ?? '';
    } catch (e) {
      print('Error loading token: $e');
      _token = '';
    }
    notifyListeners();
  }

  Future<void> _loadSelectedEvents() async {
    try {
      _selectedEvents = await _dbHelper.getSelectedEvents();
    } catch (e) {
      print('Error loading events: $e');
      _selectedEvents = [];
    }
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    try {
      await _dbHelper.insertToken(token);
      print('Token guardado en TokenProvider: $_token');  
    } catch (e) {
      print('Error setting token: $e');
    }
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    _selectedEvents.add(event);
    try {
      await _dbHelper.addEvent(event);
    } catch (e) {
      print('Error adding event: $e');
    }
    notifyListeners();
  }

  Future<void> removeEvent(Event event) async {
    _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
    try {
      await _dbHelper.removeEvent(event.uuid);
    } catch (e) {
      print('Error removing event: $e');
    }
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = '';
    try {
      await _dbHelper.deleteToken();
    } catch (e) {
      print('Error clearing token: $e');
    }
    _selectedEvents.clear();
    notifyListeners();
  }
}
