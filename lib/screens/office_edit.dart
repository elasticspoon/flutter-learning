import 'package:flutter/material.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/widgets/office_form.dart';

class OfficeEdit extends StatefulWidget {
  final Office? office;
  final String? officeId;

  OfficeEdit({this.officeId, this.office});

  @override
  State<OfficeEdit> createState() => _OfficeEditState();
}

class _OfficeEditState extends State<OfficeEdit> {
  late Future<Office?> office;

  @override
  void initState() {
    super.initState();
  }

  Future<Office?> getOffice() {
    if (widget.office != null) {
      return Future.value(widget.office);
    } else if (widget.officeId != null) {
      return show(widget.officeId!);
    } else {
      return Future.value(null);
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
          }

          final office = snapshot.data;
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OfficeForm(
                  office: office,
                )
              ],
            ),
          );
        });
  }
}
