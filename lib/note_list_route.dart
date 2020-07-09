import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'note_cell.dart';

class NoteListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("メモ"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[NoteCell(), NoteCell(), NoteCell()],
        ),
      ),
    );
  }
}
