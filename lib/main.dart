import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(MyNotesApp());

class MyNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: NotesHomePage(),
    );
  }
}
