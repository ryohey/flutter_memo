import 'package:flutter/material.dart';
import 'package:myapp/repository/note_repository.dart';
import 'package:provider/provider.dart';

import 'note_bloc.dart';
import 'note_list_route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => NoteBloc(NoteRepository()),
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
