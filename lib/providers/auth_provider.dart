import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearStorage() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('authToken');
  prefs.remove('refreshToken');
}

Future<void> setStorage(String auth, String refresh) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('authToken', auth);
  prefs.setString('refreshToken', refresh);
}
