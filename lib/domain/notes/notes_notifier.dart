import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dummy_project/model/notes/notes.dart';

final notesProvider = StateNotifierProvider<NotesNotifier, List<Notes>>(
  (ref) => NotesNotifier(ref),
);

final reviewDurationProvider = StateProvider((ref) => 5);

class NotesNotifier extends StateNotifier<List<Notes>> {
  Ref ref;
  NotesNotifier(this.ref) : super([]) {
    getAllNotes();
  }

  void addNote(String title, String content) {
    final duration = ref.read(reviewDurationProvider);
    final defaultReviewDuration = Duration(minutes: duration);
    final newNote = Notes(
      id: generateNoteId(),
      title: title,
      content: content,
      reviewInterval: defaultReviewDuration,
    );

    state = [...state, newNote];
    saveNotes();
  }

  void removeNote(int id) {
    state = state.where((note) => note.id != id).toList();
    saveNotes();
  }

  int generateNoteId() {
    return Random().nextInt(10000);
  }

  Notes getNoteById(int id) {
    return state.firstWhere((note) => note.id == id);
  }

  void editNote(int id, {String? title, String? content}) {
    state = state.map((note) {
      if (note.id == id) {
        return note.copyWith(
          title: title ?? note.title,
          content: content ?? note.content,
        );
      }
      return note;
    }).toList();
    saveNotes();
  }

  Future<void> getAllNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesString = prefs.getString('notes');
    if (notesString != null) {
      state = (json.decode(notesString) as List)
          .map((noteJson) => Notes.fromJson(noteJson))
          .toList();
    }
  }

  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notesString =
        json.encode(state.map((note) => note.toJson()).toList());
    await prefs.setString('notes', notesString);
  }
}
