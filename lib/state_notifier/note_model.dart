import 'package:myapp/repository/note_repository.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:myapp/shared/note.dart';

enum SyncState { none, loading, completed }

class NoteState {
  List<Note> notes;
  SyncState syncState;
  NoteState(this.notes, this.syncState);

  updated({
    List<Note> notes,
    SyncState syncState,
  }) {
    return NoteState(
      notes != null ? notes : this.notes,
      syncState != null ? syncState : this.syncState,
    );
  }
}

class NoteModel extends StateNotifier<NoteState> {
  NoteRepository _repository;

  NoteModel(this._repository) : super(NoteState([], SyncState.none)) {
    _fetchNotes();
  }

  void _fetchNotes() async {
    state = state.updated(syncState: SyncState.loading);
    final notes = await _repository.fetchNotes();
    state = state.updated(
      notes: state.notes + notes,
      syncState: SyncState.completed,
    );
  }

  void add(Note note) {
    state = state.updated(notes: state.notes + [note]);
  }

  Note create() {
    final uid = DateTime.now().millisecondsSinceEpoch;
    final note = Note(uid, "");
    add(note);
    return note;
  }

  void remove(int id) {
    state = state.updated(notes: state.notes.where((n) => n.id != id).toList());
  }

  void update(int id, String text) {
    remove(id);
    add(Note(id, text));
  }
}
