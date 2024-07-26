import 'dart:io';
import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Office {
  final String id;
  final String? name;
  final String? address;
  final String? city;
  final String? state;
  final String? zip;
  final double? latitude;
  final double? longitude;
  final String? open;
  final String? close;

  const Office({
    required this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.latitude,
    this.longitude,
    this.open,
    this.close,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'address': String address,
        'city': String city,
        'state': String state,
        'zip': String zip,
        'latitude': double? latitude,
        'longitude': double? longitude,
        'open': String open,
        'close': String close,
      } =>
        Office(
          id: id,
          name: name,
          address: address,
          city: city,
          state: state,
          zip: zip,
          latitude: latitude,
          longitude: longitude,
          open: open,
          close: close,
        ),
      _ => throw const FormatException('Failed to load office.'),
    };
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String? accessToken;
  List<Office?> offices = [];

  Future<void> login() async {
    final encondedToken = base64.encode(utf8.encode("admin@cc.com:admin"));
    final response = await http.get(
        Uri.parse('http://10.0.2.2:9191/public/login'),
        headers: {HttpHeaders.authorizationHeader: 'Basic $encondedToken'});

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      accessToken = responseBody['access_token'];
      print(accessToken);
    } else {
      print("bad login");
    }

    notifyListeners();
  }

  Future<void> get() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:9090/api/v1/offices'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final resp = responseBody['content'] as List<dynamic>;
      final officesList = resp.map((officeJson) {
        try {
          return Office.fromJson(officeJson as Map<String, dynamic>);
        } catch (e) {
          print(e);
        }
      }).toList();
      offices = officesList;
      print(officesList.length);
    } else {
      print("bad login");
    }

    notifyListeners();
  }

  Future<void> put() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:9090/api/v1/offices'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Authorization': 'Bearer $accessToken'
      // },
      body: jsonEncode(<String, String>{
        "id": "",
        "name": "",
        "address": "",
        "city": "",
        "state": "",
        "zip": "",
        "latitude": "",
        "longitude": "",
        "open": "",
        "close": "",
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final content = responseBody['content'];
      print(content);
    } else {
      print("bad login");
    }
  }
}

// ...

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

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.offices.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.offices.length} offices:'),
        ),
        for (var office in appState.offices)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(office!.id),
          ),
      ],
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 200, child: FavoritesPage()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  appState.login();
                },
                child: Text('Login'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.get();
                },
                child: Text('Get Offices'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.put();
                },
                child: Text('Create Office'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
