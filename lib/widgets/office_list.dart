import 'package:flutter/material.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/services/user_auth.dart';
import 'package:test_flutter/widgets/office_compact.dart';

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

  void _deleteAt(int index) {
    setState(() {
      offices = offices.then((offices) {
        offices.removeAt(index);
        return offices;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Office?>>(
      future: index(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No offices found');
        }

        final offices = snapshot.data!;
        // return GridView.builder(
        //   // Create a grid with 2 columns.
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //   ),
        //   // The itemBuilder function builds each item in the grid.
        //   itemBuilder: (context, index) {
        //     final office = offices[index];
        //     return Center(
        //       child: Text(
        //         'Office ${office!.id}',
        //         style: Theme.of(context).textTheme.headlineSmall,
        //       ),
        //     );
        //   },
        //   itemCount:
        //       offices.length, // Specify the total number of items in the grid.
        // );
        return ListView.builder(
          itemCount: offices.length,
          itemBuilder: (context, index) {
            final office = offices[index];
            return OfficeCompact(
                office: office, onDelete: () => _deleteAt(index));
          },
        );
      },
    );
  }
}
