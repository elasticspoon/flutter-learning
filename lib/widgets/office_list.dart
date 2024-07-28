import 'package:flutter/material.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/services/user_auth.dart';

import '../models.dart';

class OfficeList extends StatefulWidget {
  const OfficeList({super.key});

  @override
  State<OfficeList> createState() => _OfficeListState();
}

class _OfficeListState extends State<OfficeList> {
  late Future<List<Office?>> offices;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appAuth = UserAuth.of(context);

    return FutureBuilder<List<Office?>>(
      future: index(appAuth),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No offices found');
        }

        final offices = snapshot.data!;
        return ListView.builder(
          itemCount: offices.length,
          itemBuilder: (context, index) {
            final office = offices[index];
            return ListTile(
              title: Text(office?.id ?? 'Unknown Office'),
              tileColor: Theme.of(context).colorScheme.primary,
              hoverColor: Theme.of(context).colorScheme.secondary,
            );
          },
        );
      },
    );
  }
}
