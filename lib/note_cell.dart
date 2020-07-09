import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'note_detail_route.dart';
import 'note_model.dart';

extension NoteExtensions on Note {
  get title => text.split("\n").first;
  get dateString => DateFormat.yMd().format(createdAt);
  get summary {
    final lines = text.split("\n");
    return lines.length <= 1 ? text : lines.sublist(1).join(" ");
  }
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
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
            ])));
  }
}
