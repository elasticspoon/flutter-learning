import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/routes/router.dart';
import 'package:test_flutter/screens/office_index.dart';
import 'package:test_flutter/services/http.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/services/user_auth.dart';
import 'package:test_flutter/widgets/office_list.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserAuth()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserAuth auth = UserAuth();

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
        return UserAuthScope(
          notifier: auth,
          child: child,
        );
      },
      routerConfig: appRouter,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [OfficesIndex()],
        ),
      );
    });
  }
}
