import 'dart:io';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const authUrl = String.fromEnvironment('AUTH_URL',
    defaultValue: 'http://10.0.2.2:9191/public/login');

class AppAuth extends ChangeNotifier {
  String? _authToken;

  bool get signedIn => _authToken == null;

  Future<void> signOut() async {
    _authToken = null;
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    final encondedToken = base64.encode(utf8.encode("$username:$password"));
    final response = await http.get(Uri.parse(authUrl),
        headers: {HttpHeaders.authorizationHeader: 'Basic $encondedToken'});

    // Sign in. Allow any password.
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      _authToken = responseBody['access_token'];
    } else {
      print("bad login");
    }

    notifyListeners();
    return signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is AppAuth && other._authToken == _authToken;

  @override
  int get hashCode => _authToken.hashCode;

  static AppAuth of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppAuthScope>()!.notifier!;
}

class AppAuthScope extends InheritedNotifier<AppAuth> {
  const AppAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });
}
