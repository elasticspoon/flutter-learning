import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_flutter/models/login_response.dart';

import '../services/http.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

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

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class UserAuth with ChangeNotifier, DiagnosticableTreeMixin {
  String? _authToken, _refreshToken;

  bool signedIn() {
    return _authToken != null;
  }

  Future<void> signOut() async {
    _authToken = null;
    _refreshToken = null;

    clearStorage();
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    final encondedToken = base64.encode(utf8.encode("$username:$password"));
    final response = await HttpClient().authEndpoint.get('/public/login',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $encondedToken'
        }));

    // Sign in. Allow any password.
    if (response.statusCode == 200) {
      final loginResponse = jsonDecode(response.data) as LoginResponse;
      _authToken = loginResponse.accessToken;
      _refreshToken = loginResponse.refreshToken;
      setStorage(_authToken!, _refreshToken!);
    }

    notifyListeners();
    return Future.value(_authToken != null);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_authToken', _authToken));
    properties.add(StringProperty('_refreshToken', _refreshToken));
  }

  static UserAuth of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UserAuthScope>()!.notifier!;
}

class UserAuthScope extends InheritedNotifier<UserAuth> {
  const UserAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });
}
