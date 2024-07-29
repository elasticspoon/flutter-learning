import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/services/user_auth.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AppBar(
      title: TextButton(
        onPressed: () => context.go('/'),
        child: Text(
          'Offices',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      actions: [
        // TextButton.icon(
        //   onPressed: () {
        //     context.pop();
        //   },
        //   icon: Icon(Icons.arrow_back, color: theme.onPrimary),
        //   label: Text(
        //     'Back',
        //     style: TextStyle(color: theme.onPrimary),
        //   ),
        //   style: TextButton.styleFrom(
        //     backgroundColor: theme.primary, // Set the background color
        //   ),
        // ),
        // SizedBox(
        //   width: 8.0,
        // ),
        TextButton.icon(
          onPressed: () {
            final auth = UserAuth.of(context);
            auth.signOut();
          },
          icon: Icon(Icons.home, color: theme.onPrimary),
          label: Text(
            'Sign Out',
            style: TextStyle(color: theme.onPrimary),
          ),
          style: TextButton.styleFrom(
            backgroundColor: theme.primary, // Set the background color
          ),
        ),
      ],
    );
  }
}
