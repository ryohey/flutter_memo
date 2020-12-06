import 'package:myapp/repository/note_repository.dart';
import 'package:rxdart/subjects.dart';

import '../shared/note.dart';

enum SyncState { none, loading, completed }

class NoteBloc {
  final NoteRepository _repository;
  final _notes = BehaviorSubject<List<Note>>.seeded([]);
  final _addNoteController = PublishSubject<Note>();
  final _updateNoteController = PublishSubject<Note>();
  final _removeNoteController = PublishSubject<int>();
  final _syncState = BehaviorSubject<SyncState>.seeded(SyncState.none);

  NoteBloc(this._repository) {
    _addNoteController.stream.listen((event) {
      _notes.add(_notes.value + [event]);
    });

    _updateNoteController.stream.listen((event) {
      final newNotes =
          _notes.value.map((e) => e.id == event.id ? event : e).toList();
      _notes.add(newNotes);
    });

    _removeNoteController.stream.listen((id) {
      final newNotes = _notes.value.where((note) => note.id != id).toList();
      _notes.add(newNotes);
    });

    _fetchNotes();
  }

  void _fetchNotes() async {
    _syncState.add(SyncState.loading);
    final notes = await _repository.fetchNotes();
    _notes.add(_notes.value + notes);
    _syncState.add(SyncState.completed);
  }

  void dispose() {
    _notes.close();
    _addNoteController.close();
    _updateNoteController.close();
    _removeNoteController.close();
    _syncState.close();
  }

  Sink<Note> get addNote => _addNoteController.sink;
  Sink<Note> get updateNote => _updateNoteController.sink;
  Sink<int> get removeNote => _removeNoteController.sink;
  Stream<List<Note>> get notes => _notes.stream;
  Stream<SyncState> get syncState => _syncState.stream;
}
