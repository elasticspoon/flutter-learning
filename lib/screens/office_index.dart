import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/screens/nav_bar.dart';
import 'package:test_flutter/widgets/office_list.dart';

class OfficesIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/office/new');
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => OfficeEdit(office: office),
          //     ));
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: OfficeList(),
      ),
    );
  }
}
