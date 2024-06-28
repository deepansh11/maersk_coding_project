import 'package:dummy_project/presentation/home/widgets/add_notes_dialog.dart';
import 'package:dummy_project/presentation/notes/notes_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: SizedBox(height: homeHeight, child: const NotesList()),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (
                  context,
                ) {
                  return const AddNotes();
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
