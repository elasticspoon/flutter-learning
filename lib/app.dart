import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_flutter/services/http.dart';
import 'package:test_flutter/services/user_auth.dart';

import 'routes/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppAuth auth = AppAuth();

  @override
  void initState() {
    super.initState();
    HttpClient.initialize(auth);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        if (child == null) {
          throw ('No child in .router constructor builder');
        }
        return AppAuthScope(
          notifier: auth,
          child: child,
        );
      },
      routerConfig: appRouter,
    );
  }
}
