import 'package:rxdart/subjects.dart';

import 'note_model.dart';

class NoteBloc {
  final _notes = BehaviorSubject<List<Note>>.seeded([]);
  final _addNoteController = PublishSubject<Note>();
  final _updateNoteController = PublishSubject<Note>();
  final _removeNoteController = PublishSubject<int>();

  NoteBloc() {
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
  }

  void dispose() {
    _notes.close();
    _addNoteController.close();
    _updateNoteController.close();
    _removeNoteController.close();
  }

  Sink<Note> get addNote => _addNoteController.sink;
  Sink<Note> get updateNote => _updateNoteController.sink;
  Sink<int> get removeNote => _removeNoteController.sink;
  Stream<List<Note>> get notes => _notes.stream;
}
