import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/main.dart';
import 'package:test_flutter/providers/auth_provider.dart';

import 'package:test_flutter/screens/sign_in.dart';
import 'package:test_flutter/services/user_auth.dart';

// GoRouter configuration
final appRouter = GoRouter(
  refreshListenable: AppAuth(),
  initialLocation: '/',
  redirect: (context, state) {
    if (!AppAuth.of(context).signedIn) {
      return '/sign-in';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) {
        // Use a builder to get the correct BuildContext
        return Builder(
          builder: (context) {
            return SignInScreen(
              onSignIn: (value) async {
                final router = GoRouter.of(context);
                await AppAuth.of(context)
                    .signIn(value.username, value.password);
                router.go('/');
              },
            );
          },
        );
      },
    ),
  ],
);
