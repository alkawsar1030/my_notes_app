import 'package:flutter/material.dart';
import 'note_detail_page.dart';
import '../widgets/add_note_dialog.dart';

class NotesHomePage extends StatefulWidget {
  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  final List<String> notes = [];
  final PageController _pageController = PageController();

  void _showAddNoteDialog() async {
    final newNote = await showDialog<String>(
      context: context,
      builder: (context) => AddNoteDialog(),
    );

    if (newNote != null && newNote.isNotEmpty) {
      setState(() => notes.add(newNote));
    }
  }

  void _deleteNoteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                notes.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: PageView(
    controller: _pageController,
        children: [
          // 🟩 GridView Page
          GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) => GestureDetector(
              onLongPress: () => _deleteNoteConfirmation(index),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteDetailPage(note: notes[index]),
                ),
              ),
              child: Card(
                elevation: 3,
                color: Colors.teal.shade100,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          notes[index],
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _deleteNoteConfirmation(index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🟦 ListView Page (Swipe to delete)
          ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) => Dismissible(
              key: Key(notes[index]),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                setState(() => notes.removeAt(index));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Note deleted')));
              },
              child: ListTile(
                leading: const Icon(Icons.note),
                title: Text(notes[index]),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NoteDetailPage(note: notes[index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
