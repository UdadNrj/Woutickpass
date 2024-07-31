import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/services/token_dao.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:woutickpass/providers/token_provider.dart';
import 'package:woutickpass/screens/Sessions_screnn.dart';
import 'package:woutickpass/services/Api/api_auth_sessions.dart';

class LoginService {
  Future<String?> askToken(String gmail, String password) async {
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
      String? token = await TokenDao().retrieveToken();
      print('Token retrieved from database: $token'); // Depuración
      if (token != null && token.isNotEmpty) {
        context.read<TokenProvider>().setToken(token);

        try {
          await EventService.fetchAndStoreEvents(token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SessionsScreen(token: token),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching events: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No stored token available.')),
        );
      }
    } else {
      try {
        final token = await askToken(gmail, password);
        print('Token received from server: $token'); // Depuración
        if (token != null && token.isNotEmpty) {
          await TokenDao().insertToken(token);
          context.read<TokenProvider>().setToken(token);

          try {
            await EventService.fetchAndStoreEvents(token);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SessionsScreen(token: token),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error fetching events: $e')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Received an empty token from server.')),
          );
        }
      } catch (e) {
        debugPrint('Error during login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }
}
