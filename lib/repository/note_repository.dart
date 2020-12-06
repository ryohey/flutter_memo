import 'package:myapp/shared/note.dart';

// dummy repository
// it behaves like a storage over the internet
class NoteRepository {
  Future<List<Note>> fetchNotes() async {
    await Future.delayed(Duration(seconds: 3));
    return [
      Note(0,
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
      Note(1,
          "t enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    ];
  }
}
