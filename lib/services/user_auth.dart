import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:test_flutter/models/login_response.dart';
import 'package:test_flutter/services/http.dart';
import 'package:test_flutter/services/token_store.dart';

class UserAuth extends ChangeNotifier {
  String? authToken;
  String? refreshToken;

  UserAuth() {
    loadValidTokens();
  }

  bool get signedIn => authToken != null;

  Future<String?> get authTok async {
    if (authToken == null) {
      await loadTokens();
    }
    if (authToken != null &&
        JwtDecoder.isExpired(authToken!) &&
        refreshToken != null) {
      await refreshTokens();
    }
    return Future.value(authToken);
  }

  Future<String?> get refreshTok async {
    if (refreshToken == null) {
      await loadTokens();
    }
    return Future.value(refreshToken);
  }

  Future<void> signOut() async {
    authToken = null;
    refreshToken = null;

    clearStorage();
    notifyListeners();
  }

  Future<bool> refreshTokens() async {
    if (refreshToken == null) {
      return false;
    }

    final response = await HttpClient().authEndpoint.get('/public/refresh',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $refreshToken'
        }));

    // Sign in. Allow any password.
    if (response.statusCode == 200) {
      updateTokens(LoginResponse.fromJson(response.data));
    } else {
      print("bad login");
    }

    notifyListeners();
    return signedIn;
  }

  Future<bool> signIn(String username, String password) async {
    final encondedToken = base64.encode(utf8.encode("$username:$password"));
    final response = await HttpClient().authEndpoint.get('/public/login',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $encondedToken'
        }));

    // Sign in. Allow any password.
    if (response.statusCode == 200) {
      updateTokens(LoginResponse.fromJson(response.data));
    } else {
      print("bad login");
    }

    notifyListeners();
    return signedIn;
  }

  Future<void> loadValidTokens() async {
    final prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('authToken');
    refreshToken = prefs.getString('refreshToken');

    if (authToken == null || refreshToken == null) {
      return;
    }

    if (JwtDecoder.isExpired(authToken!) &&
        !JwtDecoder.isExpired(refreshToken!)) {
      refreshTokens();
      return;
    }

    notifyListeners();
  }

  Future<void> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('authToken');
    refreshToken = prefs.getString('refreshToken');

    notifyListeners();
  }

  Future<void> updateTokens(LoginResponse loginResponse) async {
    authToken = loginResponse.accessToken;
    refreshToken = loginResponse.refreshToken;
    setStorage(loginResponse.accessToken, loginResponse.refreshToken);

    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      other is UserAuth &&
      other.authToken == authToken &&
      other.refreshToken == refreshToken;

  @override
  int get hashCode => authToken.hashCode;

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
