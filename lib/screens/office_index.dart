import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/services/user_auth.dart';
import 'package:test_flutter/widgets/office_list.dart';

class OfficesIndex extends StatelessWidget {
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
                  final auth = UserAuth.of(context);
                  auth.signOut();
                },
                child: Text('Sign Out'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  index();
                },
                child: Text('Get Offices'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  // final id = await create();
                  context.go('/office/new');
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
