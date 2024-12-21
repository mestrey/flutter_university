import 'package:dormigram/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final ApiService _apiService = ApiService();

  String? validateNonNullField(String? str) {
    return str == null || str.isEmpty ? 'Поле не может быть пустым' : null;
  }

  String? validateEmail(String? str) {
    if (str == null || str.isEmpty) return 'Поле не может быть пустым';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(str)) return 'Некорректный адрес электронной почты';

    return null;
  }

  String? validatePassword(String? str) {
    if (str == null || str.isEmpty) return 'Поле не может быть пустым';
    if (str.length < 6) return 'Пароль должен содержать не менее 6 символов';

    return null;
  }

  String? validateConfirmPassword(String? str, String password) {
    String? error = validatePassword(str);
    if (error != null) return error;
    if (str != password) return 'Пароли не совпадают';

    return null;
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('token');

    if (token == null) {
      if (kDebugMode) print('Empty token!');
      return false;
    }

    token = token.replaceAll('"', '');

    bool isValid = await _apiService.validateToken(token);
    if (kDebugMode) print('Token: $token, valid: $isValid');

    return isValid;
  }

  Future<bool> loginSubmit(String email, String password) async {
    String? token = await _apiService.login(email, password);

    if (token == null) return false;

    SharedPreferences prefs = await _prefs;
    bool success = await prefs.setString('token', token);

    if (kDebugMode) print('Token: ${prefs.getString('token')}, success: $success');

    return success;
  }

  Future<bool> registerSubmit(
    String last,
    String first,
    String patronymic,
    String email,
    String password,
    String cPassword,
  ) async {
    String? token = await _apiService.register(last, first, patronymic, email, password, cPassword);

    if (token == null) return false;

    SharedPreferences prefs = await _prefs;
    bool success = await prefs.setString('token', token);

    if (kDebugMode) print('Token: ${prefs.getString('token')}, success: $success');

    return success;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await _prefs;
    await prefs.remove('token');
  }
}
