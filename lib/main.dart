import 'package:daily_quotes/app/locator.dart';
import 'package:daily_quotes/ui/setup_dialog_ui.dart';
import 'package:daily_quotes/ui/setup_snackbar_ui.dart';
import 'package:daily_quotes/ui/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  configure();
  setupDialogUi();
  setupSnackbarUi();
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
      navigatorKey: Get.key,
      home: HomeScreen(),
    );
  }
}
