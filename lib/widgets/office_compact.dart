import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/services/offices_api.dart';

class OfficeCompact extends StatelessWidget {
  const OfficeCompact(
      {super.key, required this.office, required this.onDelete});

  final Office? office;
  final VoidCallback onDelete;

  Future<void> deleteTile(String id) async {
    final result = await delete(id);
    if (result.success) {
      onDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.house),
      title: Text(office?.name ?? 'Unknown Office'),
      subtitle: Text(office?.city ?? 'Unknown City'),
      onTap: () {
        context.go('/office/${office?.id}', extra: office);
      },
      trailing: IconButton(
        icon: Icon(Icons.delete), // You can use any icon or widget here
        onPressed: () {
          deleteTile(office!.id);
        },
      ),
    );
  }
}
