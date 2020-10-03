import 'package:daily_quotes/app/locator.dart';
import 'package:daily_quotes/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  String _phoneNumber;
  String _smsCode;
  bool _codeSent = false;
  String _verificationId;

  String get phoneNumber => _phoneNumber;
  String get smsCode => _smsCode;
  bool get codeSent => _codeSent;
  String get verificationId => _verificationId;

  resetPhoneAndCode() {
    _phoneNumber = '';
    _smsCode = '';
    notifyListeners();
  }

  setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  setSmsCode(String value) {
    _smsCode = value;
    notifyListeners();
  }

  setCodeSentStatus(bool val) {
    _codeSent = val;
    notifyListeners();
  }

  setVerificationId(String val) {
    _verificationId = val;
    notifyListeners();
  }

  Future<void> verifyCode(String smsCode, String verificationId) async {
    try {
      await _authService.signInWithOTP(smsCode, verificationId);
    } on PlatformException catch (e) {
      showErroSnackBar('OTP Verification failed. ${e.toString()}');
    }
  }

  showErroSnackBar(String message) {
    _snackbarService.showSnackbar(message: message);
  }
}
