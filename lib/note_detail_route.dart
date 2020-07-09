import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetailRoute extends StatelessWidget {
  final myController = TextEditingController(text: "hello");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(),
        body: SingleChildScrollView(
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: 99999,
            autofocus: true,
          ),
        ));
  }
}
