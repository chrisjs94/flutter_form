import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSessionData(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
  // Puedes almacenar más datos de sesión según tus necesidades
}

Future<String> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  return username ?? '';
}

Future<bool> checkSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  return username != null && username.isNotEmpty;
}