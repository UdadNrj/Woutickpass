import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://api-dev.woutick.com/back/v1/";

  Future<String> login(String email, String password) async {
    const String url = "${_baseUrl}account/login/";
    final response = await http
        .post(Uri.parse(url), body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      return jsonData["access"];
    } else {
      throw Exception("Failed to login");
    }
  }
}
