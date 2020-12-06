import 'package:state_notifier/state_notifier.dart';

class Note {
  final int id;
  final String text;
  final DateTime createdAt = DateTime.now();

  Note(this.id, this.text);
}

class NoteState {
  List<Note> notes;
  NoteState(this.notes);
}

class NoteModel extends StateNotifier<NoteState> {
  NoteModel() : super(NoteState([]));

  void add(Note note) {
    state = NoteState(state.notes + [note]);
  }

  Note create() {
    final uid = DateTime.now().millisecondsSinceEpoch;
    final note = Note(uid, "");
    add(note);
    return note;
  }

  void remove(int id) {
    state = NoteState(state.notes.where((n) => n.id != id).toList());
  }

  void update(int id, String text) {
    remove(id);
    add(Note(id, text));
  }
}
