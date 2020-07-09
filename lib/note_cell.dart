import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'note_detail_route.dart';

class NoteCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteDetailRoute()),
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
                          'Title',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Row(
                          children: [
                            Text(
                              '日付',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '内容',
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
