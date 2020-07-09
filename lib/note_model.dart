import 'dart:collection';

import 'package:flutter/material.dart';

class Note {
  final int id;
  final String text;
  final DateTime createdAt = DateTime.now();

  Note(this.id, this.text);
}

class NoteModel extends ChangeNotifier {
  final List<Note> _notes = [Note(0, "hi")];

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  void add(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void remove(int id) {
    _notes.removeWhere((note) => note.id == id);
  }

  void update(int id, String text) {
    remove(id);
    add(Note(id, text));
  }
}
