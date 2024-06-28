import 'package:dummy_project/domain/notes/notes_notifier.dart';
import 'package:dummy_project/model/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesDetails extends ConsumerStatefulWidget {
  const NotesDetails({
    super.key,
    required this.id,
  });
  final int id;

  @override
  ConsumerState<NotesDetails> createState() => _NotesDetailsState();
}

class _NotesDetailsState extends ConsumerState<NotesDetails> {
  late Notes notes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notes = ref.read(notesProvider.notifier).getNotes(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Details'),
      ),
      body: Column(
        children: [
          Text(notes.title),
          Text(notes.content),
        ],
      ),
    );
  }
}
