import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/shared/note.dart';

import 'note_bloc.dart';
import 'note_detail_route.dart';

extension NoteExtensions on Note {
  get title => text.split("\n").first;
  get dateString => DateFormat.yMd().format(createdAt);
  get summary {
    final lines = text.split("\n");
    return lines.length <= 1 ? text : lines.sublist(1).join(" ");
  }
}

class NoteCellContent extends StatelessWidget {
  final Note note;

  NoteCellContent(this.note);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 22),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          note.dateString,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                note.summary,
                                style: Theme.of(context).textTheme.subtitle1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )),
                        ),
                      ],
                    )
                  ])),
          Divider(
            height: 0,
          ),
        ]));
  }
}

class NoteCell extends StatelessWidget {
  final Note note;

  NoteCell(this.note);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(note.id.toString()),
        onDismissed: (direction) {
          final e = RemoveNote(note.id);
          context.read<NoteBloc>().add(e);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete_forever, color: Colors.white)),
        ),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteDetailRoute(note)),
              );
            },
            child: NoteCellContent(note)));
  }
}
