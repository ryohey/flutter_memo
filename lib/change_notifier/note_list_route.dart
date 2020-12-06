import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_cell.dart';
import 'note_detail_route.dart';
import 'note_model.dart';

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

class NoteListRoute extends StatefulWidget {
  @override
  NoteListRouteState createState() => NoteListRouteState();
}

class NoteListRouteState extends State<NoteListRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _syncNotes();
  }

  void _syncNotes() async {
    await Provider.of<NoteModel>(context, listen: false).fetchNotes();
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text("Synchronization is complete")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CupertinoNavigationBar(
        middle: Text("メモ"),
      ),
      body: Column(children: [Expanded(child: NoteList()), BottomToolbar()]),
    );
  }
}
