import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:myapp/repository/note_repository.dart';
import 'package:myapp/shared/note.dart';

class NoteModel extends ChangeNotifier {
  final NoteRepository repository;
  final List<Note> _notes = [];

  NoteModel(this.repository);

  Future<void> fetchNotes() async {
    final notes = await repository.fetchNotes();
    _notes.addAll(notes);
    notifyListeners();
  }

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  void add(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  Note create() {
    final uid = DateTime.now().millisecondsSinceEpoch;
    final note = Note(uid, "");
    add(note);
    return note;
  }

  void remove(int id) {
    _notes.removeWhere((note) => note.id == id);
  }

  void update(int id, String text) {
    remove(id);
    add(Note(id, text));
  }
}
