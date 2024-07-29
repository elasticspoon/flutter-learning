import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/screens/office_edit.dart';
import 'package:test_flutter/services/offices_api.dart';
// import 'package:url_launcher/link.dart';

// import '../data.dart';
// import 'author_details.dart';

class OfficeDetailsScreen extends StatefulWidget {
  /// Creates a [OfficeDetailsScreen].
  const OfficeDetailsScreen({
    super.key,
    required this.officeId,
  });

  /// The book to be displayed.
  final String officeId;

  @override
  State<OfficeDetailsScreen> createState() => _OfficeDetailsScreenState();
}

class _OfficeDetailsScreenState extends State<OfficeDetailsScreen> {
  late Future<Office?> office;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Office?>(
        future: show(widget.officeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No offices found');
          }

          final office = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(office.name),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OfficeEdit(office: office),
                    ));
              },
              child: Icon(Icons.edit),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    office.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text('Home'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
