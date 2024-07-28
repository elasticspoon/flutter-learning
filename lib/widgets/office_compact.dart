import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/services/offices_api.dart';

class OfficeCompact extends StatelessWidget {
  const OfficeCompact(
      {super.key, required this.office, required this.onDelete});

  final Office? office;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(office?.id ?? 'Unknown Office'),
      subtitle: Text(office?.city ?? 'Unknown City'),
      onTap: () {
        context.go('/office/${office?.id}');
      },
      trailing: IconButton(
        icon: Icon(Icons.delete), // You can use any icon or widget here
        onPressed: () {
          delete(office!.id);
        },
      ),
    );
  }
}
