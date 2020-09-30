import 'package:daily_quotes/app/locator.dart';
import 'package:daily_quotes/app/routes.gr.dart';
import 'package:daily_quotes/ui/views/dialog_view.dart';
import 'package:daily_quotes/ui/views/snackbar_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // IMPLEMENTATION NOTE: Services should never be used directly in a view refer to
  // https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/#how-does-stacked-work
  // for more details.
  NavigationService _navigationService = locator<NavigationService>();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            title: Text('Dialogs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert),
            title: Text('Snackbar'),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
      appBar: AppBar(
        title: Text(
          "Home Screen",
        ),
        centerTitle: true,
      ),
      body: getViewForIndex(currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _navigationService.navigateTo(Routes.firstScreenRoute);
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget getViewForIndex(int currentIndex) {
    switch (currentIndex) {
      case 1:
        return SnackbarView();
      case 0:
      default:
        return DialogView();
    }
  }
}
