import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/note_model.dart';
import 'package:provider/provider.dart';

import 'note_cell.dart';

class NoteListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("メモ"),
      ),
      body: Consumer<NoteModel>(builder: (context, noteModel, child) {
        final cells = noteModel.notes.map((e) => NoteCell(e)).toList();
        return Column(
            mainAxisAlignment: MainAxisAlignment.start, children: cells);
      }),
    );
  }
}
