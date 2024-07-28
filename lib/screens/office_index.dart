import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/main.dart';

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
