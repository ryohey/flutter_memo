import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/note_list_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NoteListRoute(),
    );
  }
}
