import 'package:flutter/material.dart';
import 'package:woutickpass/models/Sessions_objeto..dart';
import 'package:woutickpass/services/database.dart';

class TokenProvider with ChangeNotifier {
  String _token = '';
  List<Sessions> _selectedEvents = [];

  String get token => _token;
  List<Sessions> get selectedEvents => _selectedEvents;

  final DatabaseHelper _dbHelper = DatabaseHelper();
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
      _selectedEvents = await _dbHelper.getSelectedSessions();
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

  Future<void> addEvent(Sessions event) async {
    _selectedEvents.add(event);
    try {
      await _dbHelper.addSession(event);
    } catch (e) {
      print('Error adding event: $e');
    }
    notifyListeners();
  }

  Future<void> removeEvent(Sessions event) async {
    _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
    try {
      await _dbHelper.removeSession(event.uuid);
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
