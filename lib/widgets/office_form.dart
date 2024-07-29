import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/models/office_reponse.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/widgets/required_field.dart';
import 'package:test_flutter/widgets/time_picker.dart';

// Define a custom Form widget.
class OfficeForm extends StatefulWidget {
  const OfficeForm({super.key, this.office});

  final Office? office;

  @override
  OfficeFormState createState() {
    return OfficeFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class OfficeFormState extends State<OfficeForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();
  final openController = TextEditingController();
  final closeController = TextEditingController();

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final office = Office(
      id: widget.office?.id ?? '',
      name: nameController.text,
      address: addressController.text,
      city: cityController.text,
      state: stateController.text,
      zip: zipController.text,
      open: openController.text,
      close: closeController.text,
    );

    OfficeReponse officeResult;
    if (widget.office != null) {
      officeResult = await update(office);
    } else {
      officeResult = await create(office);
    }
    if (mounted) {
      if (officeResult.success) {
        context.go('/');
      } else {
        showError(context, officeResult.error!);
      }
    }
  }

  void showError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          RequiredField(
            controller: nameController,
            initialValue: widget.office?.name,
            label: "Office Name",
          ),
          RequiredField(
            controller: addressController,
            initialValue: widget.office?.address,
            label: "Street Address",
          ),
          RequiredField(
            controller: cityController,
            initialValue: widget.office?.city,
            label: "City",
          ),
          RequiredField(
            controller: zipController,
            initialValue: widget.office?.zip,
            label: "Zip Code",
          ),
          RequiredField(
            controller: stateController,
            initialValue: widget.office?.state,
            label: "State",
          ),
          RequiredField(
            controller: openController,
            initialValue: widget.office?.open,
            label: "Open Time",
          ),
          RequiredField(
            controller: closeController,
            initialValue: widget.office?.close,
            label: "Close Time",
          ),
          ElevatedButton(
            onPressed: () {
              submitForm();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
