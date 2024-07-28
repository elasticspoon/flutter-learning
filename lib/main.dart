import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/app.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/services/user_auth.dart';
import 'package:test_flutter/widgets/office_list.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppAuth()),
    ],
    child: App(),
  ));
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
          children: [GeneratorPage()],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 200, child: OfficeList()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  final auth = AppAuth.of(context);
                  auth.signOut();
                },
                child: Text('Sign Out'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final auth = AppAuth.of(context);
                  index(auth);
                },
                child: Text('Get Offices'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                child: Text('Create Office'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
