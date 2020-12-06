import 'dart:collection';

import 'package:flutter/material.dart';

class Note {
  final int id;
  final String text;
  final DateTime createdAt = DateTime.now();

  Note(this.id, this.text);
}

class NoteModel extends ChangeNotifier {
  final List<Note> _notes = [];

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
