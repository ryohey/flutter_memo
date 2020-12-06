import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_bloc.dart';
import 'note_model.dart';

class NoteDetailRoute extends StatefulWidget {
  final Note note;

  NoteDetailRoute(this.note);

  @override
  _NoteDetailRouteState createState() => _NoteDetailRouteState(note);
}

class _NoteDetailRouteState extends State<NoteDetailRoute> {
  final Note note;
  final myController;

  _NoteDetailRouteState(this.note)
      : myController = TextEditingController(text: note.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(),
        body: SingleChildScrollView(
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: 99999,
            autofocus: true,
            onChanged: (value) {
              final noteBloc = Provider.of<NoteBloc>(context, listen: false);
              noteBloc.updateNote.add(Note(note.id, value));
            },
          ),
        ));
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
