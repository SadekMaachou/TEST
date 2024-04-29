import 'package:flutter/material.dart';
import 'package:notes/DatabaseHelper';
import 'package:notes/details_page.dart';

import 'note.dart';
// Import the database helper class

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _noteController = TextEditingController();
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance; // Instantiate the database helper class

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('New Note'),
                  content: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your note',
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () async {
                        await _databaseHelper.insert(Note(
                          note: _noteController.text,
                          date: DateTime.now(),
                        ));
                        setState(() {
                          // Refresh the UI
                        });
                        _noteController.clear();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _databaseHelper.queryAllRows(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final List<Map<String, dynamic>> notes = snapshot.data ?? [];
              return notes.isEmpty
                  ? const Center(
                      child: Text("NO NOTES AVAILABLE"),
                    )
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = Note.fromMap(notes[index]);
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(note: note),
                              ),
                            );
                          },
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage('assets/avatar.png'),
                          ),
                          title: const Text(
                            'Maachou',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            note.note,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
