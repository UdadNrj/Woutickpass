import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';

class TokenProvider with ChangeNotifier {
  String _token = '';
  List<Session> _selectedEvents = [];

  String get token => _token;
  List<Session> get selectedEvents => _selectedEvents;

  TokenProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Asegúrate de que el token siempre esté vacío al inicializar para que el usuario tenga que iniciar sesión.
    _token =
        ''; // Esto asegura que el token esté vacío cada vez que se inicia la aplicación
    _selectedEvents = [];
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    print('Token guardado en TokenProvider: $_token');
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = '';
    print('Token cleared in TokenProvider');
    _selectedEvents.clear();
    notifyListeners();
  }

  Future<void> addEvent(Session event) async {
    _selectedEvents.add(event);
    print('Event added in TokenProvider: $event');
    notifyListeners();
  }

  Future<void> removeEvent(Session event) async {
    _selectedEvents.removeWhere((e) => e.uuid == event.uuid);
    print('Event removed in TokenProvider: $event');
    notifyListeners();
  }
}
