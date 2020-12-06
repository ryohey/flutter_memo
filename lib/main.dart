import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'change_notifier/my_app.dart';

const architecture =
    String.fromEnvironment('APP_ARCH', defaultValue: 'change_notifier');

void main() {
  runApp(app());
}

Widget app() {
  switch (architecture) {
    case "change_notifier":
    default:
      return MyApp();
  }
}
