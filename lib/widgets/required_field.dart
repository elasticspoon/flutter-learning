import 'package:flutter/material.dart';

class RequiredField extends StatelessWidget {
  const RequiredField(
      {super.key,
      required this.label,
      required this.controller,
      this.initialValue});

  final TextEditingController controller;
  final String label;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) {
      controller.text = initialValue!;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
