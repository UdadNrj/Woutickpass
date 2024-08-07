import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/providers/token_provider.dart';
import 'package:woutickpass/screens/Sessions_screnn.dart';
import 'package:woutickpass/services/api/auth_session_api.dart';
import 'package:woutickpass/services/dao/token_dao.dart';

class AuthLoginAPI {
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
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No internet connection. Logging in offline.')),
      );

      final token = await TokenDAO().retrieveToken();
      if (token != null && token.isNotEmpty) {
        context.read<TokenProvider>().setToken(token);

        try {
          await AuthSessionAPI.fetchAndStoreSessions(token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SessionsScreen(token: token)),
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
        if (token != null && token.isNotEmpty) {
          await TokenDAO().insertToken(token);
          context.read<TokenProvider>().setToken(token);

          try {
            await AuthSessionAPI.fetchAndStoreSessions(token);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SessionsScreen(token: token)),
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
