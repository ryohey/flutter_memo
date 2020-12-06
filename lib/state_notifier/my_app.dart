import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:myapp/repository/note_repository.dart';

import 'note_list_route.dart';
import 'note_model.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<NoteModel, NoteState>(
        create: (context) => NoteModel(NoteRepository()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: NoteListRoute(),
        ));
  }
}
