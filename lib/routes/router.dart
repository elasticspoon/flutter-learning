import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/screens/office_edit.dart';
import 'package:test_flutter/screens/office_index.dart';
import 'package:test_flutter/screens/sign_in.dart';
import 'package:test_flutter/services/user_auth.dart';
import 'package:test_flutter/widgets/office_details.dart';

// GoRouter configuration
final appRouter = GoRouter(
  refreshListenable: UserAuth(),
  initialLocation: '/',
  redirect: (context, state) {
    if (!UserAuth.of(context).signedIn) {
      return '/sign-in';
    }
    if (state.matchedLocation == '/sign-in') {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => OfficesIndex(),
    ),
    GoRoute(
        path: '/office/:officeId/edit',
        builder: (BuildContext context, GoRouterState state) {
          final String officeId = state.pathParameters['officeId']!;
          final Office? office = state.extra as Office?;

          return OfficeEdit(office: office, officeId: officeId);
        }),
    GoRoute(
        path: '/office/new',
        builder: (BuildContext context, GoRouterState state) {
          return OfficeEdit();
        }),
    GoRoute(
        path: '/office/:officeId',
        builder: (BuildContext context, GoRouterState state) {
          final String officeId = state.pathParameters['officeId']!;
          final Office? office = state.extra as Office?;

          return OfficeDetailsScreen(
            office: office,
            officeId: officeId,
          );
        }),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) {
        // Use a builder to get the correct BuildContext
        return Builder(
          builder: (context) {
            return SignInScreen(
              onSignIn: (value) async {
                final router = GoRouter.of(context);
                await UserAuth.of(context)
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
