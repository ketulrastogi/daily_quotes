import 'package:daily_quotes/ui/views/home/home_view.dart';
import 'package:daily_quotes/ui/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomeView();
          } else {
            return LoginView();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCreds);
    User user = userCredential.user;
  }

  signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    await signIn(authCreds);
  }
}
