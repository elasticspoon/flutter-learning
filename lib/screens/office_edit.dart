import 'package:flutter/material.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/screens/nav_bar.dart';
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
          }

          final office = snapshot.data;
          return Scaffold(
            appBar: NavBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OfficeForm(
                      office: office,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
