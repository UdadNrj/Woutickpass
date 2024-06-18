import 'package:flutter/material.dart';

class TokenProvider with ChangeNotifier {
  String _token = "";

  String get token => _token;

  void change(String newToken) {
    _token = newToken;
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
