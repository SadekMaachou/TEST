import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'note.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Add a back arrow button
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Stop speaking when back button is pressed
              FlutterTts flutterTts = FlutterTts();
              flutterTts.stop();
              // Navigate back to the home page
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: NoteDetailsCol(note: note),
          ),
        ),
      ),
    );
  }
}

class NoteDetailsCol extends StatelessWidget {
  NoteDetailsCol({Key? key, required this.note}) : super(key: key);

  final Note note;
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/avatar.png',
          width: 100,
          height: 100,
        ),
        const Text('Maachou Sadek'),
        Text(
          note.note,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          note.date.toString(),
          style: const TextStyle(fontSize: 16),
        ),
        ElevatedButton(
          onPressed: () {
            flutterTts.speak(note.note);
          },
          child: Text('Speak'),
        ),
      ],
    );
  }
}
