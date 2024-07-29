import 'package:flutter/material.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/models/office_reponse.dart';
import 'package:test_flutter/services/offices_api.dart';
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
    offices = fetchOffices();
  }

  Future<List<Office?>> fetchOffices() async {
    OfficeReponse response = await index();
    if (response.success) {
      return response.offices!;
    } else {
      throw Exception(response.error!);
    }
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
      future: offices,
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
            return OfficeCompact(
                office: office, onDelete: () => _deleteAt(index));
          },
        );
      },
    );
  }
}
