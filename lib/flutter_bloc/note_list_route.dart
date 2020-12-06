import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/shared/note.dart';

import 'note_bloc.dart';
import 'note_cell.dart';
import 'note_detail_route.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      final cells = state.notes.map((e) => NoteCell(e)).toList();
      return ListView(children: cells);
    });
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        final note = Note.create();
        context.read<NoteBloc>().add(AddNote(note));
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
      body: BlocListener<NoteBloc, NoteState>(
          listenWhen: (previous, current) =>
              previous.syncState != current.syncState,
          listener: (context, state) {
            if (state.syncState == SyncState.completed) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Synchronization is complete")));
            }
          },
          child:
              Column(children: [Expanded(child: NoteList()), BottomToolbar()])),
    );
  }
}
