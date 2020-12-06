import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'state_notifier/my_app.dart' as StateNotifierApp;
import 'change_notifier/my_app.dart' as ChangeNotifierApp;

const architecture =
    String.fromEnvironment('APP_ARCH', defaultValue: 'change_notifier');

void main() {
  runApp(app());
}

Widget app() {
  switch (architecture) {
    case "state_notifier":
      return StateNotifierApp.MyApp();
    case "change_notifier":
    default:
      return ChangeNotifierApp.MyApp();
  }
}
