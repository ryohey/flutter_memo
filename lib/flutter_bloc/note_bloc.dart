import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/repository/note_repository.dart';
import 'package:myapp/shared/note.dart';

abstract class NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;
  AddNote(this.note);
}

class UpdateNote extends NoteEvent {
  final Note note;
  UpdateNote(this.note);
}

class RemoveNote extends NoteEvent {
  final int id;
  RemoveNote(this.id);
}

class FetchNotes extends NoteEvent {}

enum SyncState { none, loading, completed }

class NoteState {
  final List<Note> notes;
  final SyncState syncState;

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

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _repository;

  NoteBloc(this._repository) : super(NoteState([], SyncState.none)) {
    add(FetchNotes());
  }

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is AddNote) {
      yield state.updated(notes: state.notes + [event.note]);
    } else if (event is UpdateNote) {
      yield state.updated(
          notes: state.notes
              .map((e) => e.id == event.note.id ? event.note : e)
              .toList());
    } else if (event is RemoveNote) {
      yield state.updated(
          notes: state.notes.where((note) => note.id != event.id).toList());
    } else if (event is FetchNotes) {
      yield* _mapFetchNotesToState();
    }
  }

  Stream<NoteState> _mapFetchNotesToState() async* {
    yield state.updated(syncState: SyncState.loading);
    final notes = await _repository.fetchNotes();
    yield state.updated(
      notes: state.notes + notes,
      syncState: SyncState.completed,
    );
  }
}
