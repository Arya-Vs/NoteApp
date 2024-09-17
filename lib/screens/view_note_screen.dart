import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/screens/add_note_screen.dart';

class ViewNoteScreen extends StatelessWidget {
  final Map note;
  const ViewNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(note["date"]);
    final formattedDate = DateFormat.yMMMMd('en_US').format(dateTime);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'View Note',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNoteScreen(
                    add: false,
                    title: note["title"],
                    description: note["content"],
                    id: note["id"],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              note["title"] ?? "No Title",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              note["content"] ?? "No Content",
              style: const TextStyle(
                fontSize: 20,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
