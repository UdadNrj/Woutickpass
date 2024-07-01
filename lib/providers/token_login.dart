import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider with ChangeNotifier {
  String _token = "";

  String get token => _token;

  TokenProvider() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? "";
    notifyListeners();
  }

  Future<void> changeToken(String newToken) async {
    _token = newToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', newToken);
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
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
