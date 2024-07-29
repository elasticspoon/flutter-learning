import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/services/offices_api.dart';
import 'package:test_flutter/widgets/required_field.dart';

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
  final openController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();
  final closeController = TextEditingController();

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
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
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
                if (widget.office != null) {
                  update(office);
                } else {
                  create(office);
                }
                context.go('/office/${office.id}');
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
