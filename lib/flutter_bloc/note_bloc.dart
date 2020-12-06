import 'package:flutter_bloc/flutter_bloc.dart';
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

class NoteBloc extends Bloc<NoteEvent, List<Note>> {
  NoteBloc() : super([]);

  @override
  Stream<List<Note>> mapEventToState(NoteEvent event) async* {
    if (event is AddNote) {
      yield state + [event.note];
    } else if (event is UpdateNote) {
      yield state.map((e) => e.id == event.note.id ? event.note : e).toList();
    } else if (event is RemoveNote) {
      yield state.where((note) => note.id != event.id).toList();
    }
  }
}
