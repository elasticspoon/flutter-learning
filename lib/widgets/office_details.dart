import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/screens/nav_bar.dart';
import 'package:test_flutter/services/offices_api.dart';

class OfficeDetailsScreen extends StatefulWidget {
  /// Creates a [OfficeDetailsScreen].
  const OfficeDetailsScreen({super.key, this.officeId, this.office});

  final Office? office;
  final String? officeId;

  @override
  State<OfficeDetailsScreen> createState() => _OfficeDetailsScreenState();
}

class _OfficeDetailsScreenState extends State<OfficeDetailsScreen> {
  late Future<Office?> office;

  @override
  void initState() {
    super.initState();
  }

  Future<Office?> getOffice() async {
    if (widget.office != null) {
      return widget.office;
    } else if (widget.officeId != null) {
      final result = await show(widget.officeId!);
      if (result.success) {
        return result.office;
      } else {
        throw Exception(result.error);
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Office?>(
        future: getOffice(),
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
            appBar: NavBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.go('/office/${office.id}/edit', extra: office);
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
                ],
              ),
            ),
          );
        });
  }
}
