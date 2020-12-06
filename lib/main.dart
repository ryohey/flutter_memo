import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bloc/my_app.dart' as BlocApp;
import 'flutter_bloc/my_app.dart' as FlutterBlocApp;
import 'state_notifier/my_app.dart' as StateNotifierApp;
import 'change_notifier/my_app.dart' as ChangeNotifierApp;

const architecture =
    String.fromEnvironment('APP_ARCH', defaultValue: 'change_notifier');

void main() {
  runApp(app());
}

Widget app() {
  switch (architecture) {
    case "bloc":
      return BlocApp.MyApp();
    case "flutter_bloc":
      return FlutterBlocApp.MyApp();
    case "state_notifier":
      return StateNotifierApp.MyApp();
    case "change_notifier":
    default:
      return ChangeNotifierApp.MyApp();
  }
}
