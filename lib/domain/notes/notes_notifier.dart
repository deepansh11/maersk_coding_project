import 'dart:math';

import 'package:dummy_project/model/notes/notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notesProvider = StateNotifierProvider<NotesNotifier, List<Notes>>(
    (ref) => NotesNotifier(ref));

final reviewDurationinMins = StateProvider((ref) => 5);

class NotesNotifier extends StateNotifier<List<Notes>> {
  Ref ref;
  final notesList = NotesList();

  NotesNotifier(this.ref) : super([]);

  void addToNotes(Notes notes) {
    final durationProvider = ref.read(reviewDurationinMins);
    Duration defaultReviewDuration = Duration(minutes: durationProvider);

    notesList.list.add(Notes(
      id: notes.id,
      title: notes.title,
      content: notes.content,
      reviewInterval: defaultReviewDuration,
    ));

    state = notesList.list;
  }

  void removeToNotes(int id) {
    state.removeWhere((e) => e.id == id);
  }

  int generateNotesId() {
    final id = Random().nextInt(10000);
    return id;
  }

  Notes getNotes(int id) {
    return state.firstWhere(
      (element) => element.id == id,
    );
  }

  Notes editNotes(int id, String? title, String? content) {
    Notes note = state.firstWhere(
      (element) => element.id == id,
    );

    if (content != null) note.content = content;

    if (title != null) note.title = title;

    return note;
  }

  List<Notes> getAllNotes() {
    return notesList.list;
  }
}
