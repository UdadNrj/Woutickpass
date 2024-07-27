import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/services/token_dao.dart';
import 'package:woutickpass/services/sessions_dao.dart';
=======
import 'package:woutickpass/models/Sessions_objeto..dart';
import 'package:woutickpass/services/database.dart';
>>>>>>> parent of dc54c47 (Cambios grandes !)

class TokenProvider with ChangeNotifier {
  String _token = '';
  List<Session> _selectedEvents = [];

  String get token => _token;
  List<Session> get selectedEvents => _selectedEvents;

<<<<<<< HEAD
  final TokenDao _tokenDao = TokenDao();
  final SessionsDao _sessionsDao = SessionsDao();

=======
  final DatabaseHelper _dbHelper = DatabaseHelper();
>>>>>>> parent of dc54c47 (Cambios grandes !)
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
<<<<<<< HEAD
      await _tokenDao.insertToken(token);
      print('Token guardado en TokenProvider: $_token');
=======
      await _dbHelper.insertToken(token);
      print('Token guardado en TokenProvider: $_token');  
>>>>>>> parent of dc54c47 (Cambios grandes !)
    } catch (e) {
      print('Error setting token: $e');
    }
    notifyListeners();
  }

  Future<void> addEvent(Session event) async {
    _selectedEvents.add(event);
    try {
      await _dbHelper.addSession(event);
    } catch (e) {
      print('Error adding event: $e');
    }
    notifyListeners();
  }

  Future<void> removeEvent(Session event) async {
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
