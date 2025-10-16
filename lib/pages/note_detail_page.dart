import 'package:flutter/material.dart';

class NoteDetailPage extends StatelessWidget {
  final String note;
  const NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Note Detail')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            note,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
