import 'package:flutter/material.dart';

// Define a custom Form widget.
class OfficeForm extends StatefulWidget {
  const OfficeForm({super.key});

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
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          RequiredField(nameController),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}

class RequiredField extends StatelessWidget {
  const RequiredField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: controller,
    );
  }
}
