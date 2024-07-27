// auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/services/Api/api_auth_login.dart
import 'package:provider/provider.dart';
import 'package:woutickpass/services/Api/api_auth_sessions.dart';
import 'package:woutickpass/services/token_dao.dart';
=======
>>>>>>> parent of dc54c47 (Cambios grandes !):lib/services/Api/auth_login.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/providers/token_provider.dart';
<<<<<<< HEAD:lib/services/Api/api_auth_login.dart
=======
import 'package:woutickpass/screens/Sessions_screnn.dart';
import 'package:woutickpass/services/database.dart';
import 'package:woutickpass/services/api/auth_events.dart';
>>>>>>> parent of dc54c47 (Cambios grandes !):lib/services/Api/auth_login.dart

class LoginService {
  Future<String> askToken(String gmail, String password) async {
    const String url = "https://api-dev.woutick.com/back/v1/account/login/";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'email': gmail, 'password': password},
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        return jsonData["access"];
      } else {
        throw Exception(
            "Fallo a la hora de pedir los datos. Código de estado: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Error al pedir el token: $e');
      throw Exception("Fallo a la hora de pedir los datos. Detalles: $e");
    }
  }

  Future<void> login(
      BuildContext context, String gmail, String password) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No internet connection. Logging in offline.')),
      );
      String? token = await DatabaseHelper().retrieveToken();
      if (token != null) {
        context.read<TokenProvider>().setToken(token);

        await EventService.fetchAndStoreEvents(token);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EventsScreen(token: token),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No stored token available.')),
        );
      }
    } else {
      try {
        final token = await askToken(gmail, password);
        if (token.isNotEmpty) {
          await DatabaseHelper().insertToken(token);

          await EventService.updateEvents(token);

          context.read<TokenProvider>().setToken(token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EventsScreen(token: token),
            ),
          );
        }
      } catch (e) {
        print('Error al guardar el token: $e');
      }
    }
  }
}
