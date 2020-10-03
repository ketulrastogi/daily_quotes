import 'package:daily_quotes/app/locator.dart';
import 'package:daily_quotes/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();

  signOut() {
    _authService.signOut();
  }
}
