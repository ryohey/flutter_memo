import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_cell.dart';
import 'note_detail_route.dart';
import 'note_model.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cells = context
        .select((NoteState state) => state.notes)
        .map((e) => NoteCell(e))
        .toList();
    return ListView(children: cells);
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        final noteModel = context.read<NoteModel>();
        final note = noteModel.create();
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

class NoteListRoute extends StatefulWidget {
  @override
  NoteListRouteState createState() => NoteListRouteState();
}

class NoteListRouteState extends State<NoteListRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<NoteState> _subscription;

  @override
  void didChangeDependencies() {
    final noteModel = context.read<NoteModel>();
    _subscription?.cancel();
    _subscription = noteModel.stream
        .distinct((prev, current) => prev.syncState != current.syncState)
        .listen((state) {
      if (state.syncState == SyncState.completed) {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Synchronization is complete")));
      }
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
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
