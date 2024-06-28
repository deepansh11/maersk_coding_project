import 'package:dummy_project/domain/notes/notes_notifier.dart';
import 'package:dummy_project/presentation/home/widgets/add_notes_dialog.dart';
import 'package:dummy_project/presentation/notes/notes_details.dart';
import 'package:dummy_project/presentation/notes/widgets/notes_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesList extends ConsumerStatefulWidget {
  const NotesList({super.key});

  @override
  ConsumerState<NotesList> createState() => _NotesListState();
}

class _NotesListState extends ConsumerState<NotesList> {
  @override
  Widget build(BuildContext context) {
    final notesList = ref.watch(notesProvider);
    final notesNotifier = ref.read(notesProvider.notifier);

    return ListView.builder(
      itemBuilder: (context, index) {
        final notes = notesList.elementAt(index);

        return NotesListTile(
          notes: notes,
          onDelete: () {
            setState(() {
              notesNotifier.removeNote(notes.id);
            });
          },
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotesDetails(id: notes.id)));
          },
          onEdit: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddNotes(
                    notes: notes,
                    isForEdit: true,
                  );
                });
          },
        );
      },
      itemCount: notesList.length,
    );
  }
}
