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
            body: Padding(
              padding: EdgeInsets.all(36.0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Name'),
                    subtitle: Text(office.name),
                  ),
                  ListTile(
                    title: Text('Address'),
                    subtitle: Text(office.address),
                  ),
                  ListTile(
                    title: Text('City'),
                    subtitle: Text(office.city),
                  ),
                  ListTile(
                    title: Text('State'),
                    subtitle: Text(office.state),
                  ),
                  ListTile(
                    title: Text('ZIP Code'),
                    subtitle: Text(office.zip),
                  ),
                  ListTile(
                    title: Text('Open'),
                    subtitle: Text(office.open),
                  ),
                  ListTile(
                    title: Text('Close'),
                    subtitle: Text(office.close),
                  ),
                  if (office.latitude != null && office.longitude != null)
                    ListTile(
                      title: Text('Coordinates'),
                      subtitle: Text(
                          'Lat: ${office.latitude}, Long: ${office.longitude}'),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
