import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'note_detail_route.dart';
import 'note_model.dart';

extension NoteExtensions on Note {
  get title => text.split("\n").first;
  get dateString => DateFormat.yMd().format(createdAt);
}

class NoteCell extends StatelessWidget {
  final Note note;

  NoteCell(this.note);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteDetailRoute(note)),
          );
        },
        child: Padding(
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
                        ),
                        Row(
                          children: [
                            Text(
                              note.dateString,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                note.text,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        )
                      ])),
              Divider(
                height: 0,
              ),
            ])));
  }
}
