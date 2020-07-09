import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/note_model.dart';
import 'package:provider/provider.dart';

import 'note_cell.dart';
import 'note_detail_route.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteModel>(builder: (context, noteModel, child) {
      final cells = noteModel.notes.map((e) => NoteCell(e)).toList();
      return ListView(children: cells);
    });
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteModel>(
        builder: (context, noteModel, child) => CupertinoButton(
              onPressed: () {
                final note = noteModel.create();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoteDetailRoute(note)),
                );
              },
              child: Text("Add"),
            ));
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
