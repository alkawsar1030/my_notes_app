import 'package:flutter/material.dart';

/// ✅ এই উইজেটটি ডিলিট কনফার্মেশন ডায়লগ দেখায়
class DeleteConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteConfirmDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Note'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          onPressed: () {
            onConfirm(); // 👈 আসল ডিলিট কাজটা এখানে হবে
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
