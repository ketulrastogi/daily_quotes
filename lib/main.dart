import 'package:daily_quotes/app/locator.dart';
import 'package:daily_quotes/services/auth_service.dart';
import 'package:daily_quotes/ui/setup_dialog_ui.dart';
import 'package:daily_quotes/ui/setup_snackbar_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configure();
  setupDialogUi();
  setupSnackbarUi();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = locator<AuthService>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Get.key,
      home: _authService.handleAuth(),
    );
  }
}
