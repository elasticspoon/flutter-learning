import 'package:go_router/go_router.dart';
import 'package:test_flutter/main.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(),
    ),
  ],
);
