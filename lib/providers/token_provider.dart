import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/services/sessions_dao.dart';
import 'package:woutickpass/services/token_dao.dart';

class TokenProvider with ChangeNotifier {
  String _token = '';
  List<Session> _selectedEvents = [];

  String get token => _token;
  List<Session> get selectedEvents => _selectedEvents;

  final TokenDao _tokenDao = TokenDao();
  final SessionsDao _sessionsDao = SessionsDao();

  TokenProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.wait([
      _loadToken(),
      _loadSelectedEvents(),
    ]);
  }

  Future<void> _loadToken() async {
    try {
      final token = await _tokenDao.retrieveToken();
      _token = token ??
          ''; // Asignar directamente el token obtenido o una cadena vacía si es null
      print('Token loaded in TokenProvider: $_token'); // Depuración
    } catch (e) {
      print('Error loading token: $e');
      _token = ''; // Valor predeterminado en caso de error
    }
    notifyListeners();
  }

  Future<void> _loadSelectedEvents() async {
    try {
      _selectedEvents = await _sessionsDao.getSelectedSessions();
      print(
          'Selected events loaded in TokenProvider: $_selectedEvents'); // Depuración
    } catch (e) {
      print('Error loading events: $e');
      _selectedEvents = []; // Valor predeterminado en caso de error
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

  Future<void> addEvent(Session event) async {
    _selectedEvents.add(event);
    try {
      await _sessionsDao.addSession(event);
      print('Event added in TokenProvider: $event'); // Depuración
    } catch (e) {
      print('Error adding event: $e');
    }
    notifyListeners();
  }

  Future<void> removeEvent(Session event) async {
    _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
    try {
      await _sessionsDao.removeSession(event.uuid);
      print('Event removed in TokenProvider: $event'); // Depuración
    } catch (e) {
      print('Error removing event: $e');
    }
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = '';
    try {
      await _tokenDao.deleteToken();
      print('Token cleared in TokenProvider');
    } catch (e) {
      print('Error clearing token: $e');
    }
    _selectedEvents.clear();
    notifyListeners();
  }
}

// class TokenProvider with ChangeNotifier {
//   String _token = 'token_de_prueba'; // Valor de prueba predeterminado
//   List<Session> _selectedEvents = [];

//   String get token => _token;
//   List<Session> get selectedEvents => _selectedEvents;

//   TokenProvider() {
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     await _loadSelectedEvents(); // Solo carga eventos seleccionados
//   }

//   Future<void> _loadSelectedEvents() async {
//     try {
//       // Simula la carga de eventos seleccionados
//       _selectedEvents = [];
//       print(
//           'Selected events loaded in TokenProvider: $_selectedEvents'); // Depuración
//     } catch (e) {
//       print('Error loading events: $e');
//       _selectedEvents = []; // Valor predeterminado en caso de error
//     }
//     notifyListeners();
//   }

//   Future<void> setToken(String token) async {
//     _token = token;
//     print('Token guardado en TokenProvider: $_token');
//     notifyListeners();
//   }

//   Future<void> addEvent(Session event) async {
//     _selectedEvents.add(event);
//     print('Event added in TokenProvider: $event'); // Depuración
//     notifyListeners();
//   }

//   Future<void> removeEvent(Session event) async {
//     _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
//     print('Event removed in TokenProvider: $event'); // Depuración
//     notifyListeners();
//   }

//   Future<void> clearToken() async {
//     _token = '';
//     print('Token cleared in TokenProvider');
//     _selectedEvents.clear();
//     notifyListeners();
//   }
// }
