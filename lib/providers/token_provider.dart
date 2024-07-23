import 'package:flutter/material.dart';
import 'package:woutickpass/models/Sessions_objeto..dart';
import 'package:woutickpass/services/token_dao.dart';
import 'package:woutickpass/services/sessions_dao.dart'; 

class TokenProvider with ChangeNotifier {
  String _token = '';
  List<Sessions> _selectedEvents = [];

  String get token => _token;
  List<Sessions> get selectedEvents => _selectedEvents;

  final TokenDao _tokenDao = TokenDao();
  final SessionsDao _sessionsDao = SessionsDao(); 

  TokenProvider() {
    _loadToken();
    _loadSelectedEvents();
  }

  Future<void> _loadToken() async {
    try {
      _token = await _tokenDao.retrieveToken() ?? '';
    } catch (e) {
      print('Error loading token: $e');
      _token = '';
    }
    notifyListeners();
  }

  Future<void> _loadSelectedEvents() async {
    try {
      _selectedEvents = await _sessionsDao.getSelectedSessions();
    } catch (e) {
      print('Error loading events: $e');
      _selectedEvents = [];
    }
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    try {
      await _tokenDao.insertToken(token);
      print('Token guardado en TokenProvider: $_token');  
    } catch (e) {
      print('Error setting token: $e');
    }
    notifyListeners();
  }

  Future<void> addEvent(Sessions event) async {
    _selectedEvents.add(event);
    try {
      await _sessionsDao.addSession(event);
    } catch (e) {
      print('Error adding event: $e');
    }
    notifyListeners();
  }

  Future<void> removeEvent(Sessions event) async {
    _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
    try {
      await _sessionsDao.removeSession(event.uuid);
    } catch (e) {
      print('Error removing event: $e');
    }
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = '';
    try {
      await _tokenDao.deleteToken();
    } catch (e) {
      print('Error clearing token: $e');
    }
    _selectedEvents.clear();
    notifyListeners();
  }
}
