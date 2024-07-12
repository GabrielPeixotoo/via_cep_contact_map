import 'package:flutter/material.dart';

import '../app.dart';
import '../app_module.dart';

Future<void> run() async {
  await AppModule().init();

  runApp(App());
}
