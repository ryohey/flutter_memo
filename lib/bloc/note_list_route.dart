import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_bloc.dart';
import 'note_cell.dart';
import 'note_detail_route.dart';
import '../shared/note.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteBloc = Provider.of<NoteBloc>(context, listen: false);
    return StreamBuilder<List<Note>>(
        stream: noteBloc.notes,
        builder: (context, notes) {
          final cells = (notes?.data ?? []).map((e) => NoteCell(e)).toList();
          return ListView(children: cells);
        });
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        final noteBloc = Provider.of<NoteBloc>(context, listen: false);
        final note = Note.create();
        noteBloc.addNote.add(note);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoteDetailRoute(note)),
        );
      },
      child: Text("Add"),
    );
  }
}

class BottomToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [AddButton()],
    );
  }
}

class NoteListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("メモ"),
      ),
      body: Column(children: [Expanded(child: NoteList()), BottomToolbar()]),
    );
  }
}
