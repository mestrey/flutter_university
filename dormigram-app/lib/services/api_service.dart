import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://da70-87-229-242-48.ngrok-free.app/api';

  Future<bool> validateToken(String token) async {
    token = 'Bearer $token';

    final response = await http.get(Uri.parse('$baseUrl/auth/validate'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': '69420',
      'Authorization': token,
    });

    return response.statusCode == 200 && response.body == 'true';
  }

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return response.statusCode == 200 ? response.body : null;
  }

  Future<String?> register(
    String last,
    String first,
    String patronymic,
    String email,
    String password,
    String cPassword,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json; charset=utf-8', 'Accept': 'application/json'},
      body: jsonEncode({
        'last': last,
        'first': first,
        'patronymic': patronymic,
        'email': email,
        'password': password,
        'c_password': cPassword
      }),
    );

    return response.statusCode == 200 ? response.body : null;
  }
}
