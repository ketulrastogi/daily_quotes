import 'package:daily_quotes/app/locator.dart';
import 'package:daily_quotes/services/auth_service.dart';
import 'package:daily_quotes/ui/views/login/login_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        onModelReady: (model) => model.resetPhoneAndCode(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              body: model.codeSent
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 32.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Verify OTP',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'Enter SMS Code sent your phone number.',
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                  controller: _codeController,
                                  style: TextStyle(fontSize: 24.0),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'SMS Code',
                                    labelStyle: TextStyle(fontSize: 18.0),
                                    hintText: '123-456',
                                    hintStyle: TextStyle(fontSize: 24.0),
                                    // prefixText: '+91  ',
                                  ),
                                  maxLength: 6,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'SMS Code can not be empty';
                                    } else if (value.length != 6) {
                                      return 'SMS Code must be of 6 digits';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    model.setSmsCode(value);
                                    // setState(() {
                                    //   _smsCode = value;
                                    // });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              RaisedButton(
                                padding: EdgeInsets.all(20.0),
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Text(
                                  'VERIFY',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                onPressed: () async {
                                  print(
                                      'VerificationId: ${model.verificationId} \n SmsCode: ${model.smsCode}');
                                  try {
                                    await model.verifyCode(
                                        model.smsCode, model.verificationId);
                                    _codeController.clear();
                                  } on PlatformException catch (e) {
                                    model.showErroSnackBar(
                                        'OTP Verification failed. ${e.toString()}');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 32.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Verify Phone',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'We will send you a 6-digit sms code.',
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                  controller: _phoneController,
                                  style: TextStyle(fontSize: 24.0),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone number',
                                    labelStyle: TextStyle(fontSize: 18.0),
                                    hintText: '987-654-3210',
                                    hintStyle: TextStyle(fontSize: 24.0),
                                    prefixText: '+91  ',
                                  ),
                                  maxLength: 10,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Phone number can not be empty';
                                    } else if (value.length != 10) {
                                      return 'Phone number must be of 10 digits';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    model.setPhoneNumber('+91$value');
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              RaisedButton(
                                padding: EdgeInsets.all(20.0),
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Text(
                                  'SEND OTP',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                onPressed: () async {
                                  print(model.phoneNumber);
                                  _phoneController.clear();
                                  final PhoneVerificationCompleted verified =
                                      (AuthCredential authResult) {
                                    AuthService().signIn(authResult);
                                  };

                                  final PhoneVerificationFailed
                                      verificationfailed =
                                      (FirebaseAuthException authException) {
                                    print('${authException.message}');
                                    model.showErroSnackBar(
                                        '${authException.message}');
                                  };

                                  final PhoneCodeSent smsSent =
                                      (String verId, [int forceResend]) {
                                    model.setVerificationId(verId);
                                    model.setCodeSentStatus(true);
                                  };

                                  final PhoneCodeAutoRetrievalTimeout
                                      autoTimeout = (String verId) {
                                    model.setVerificationId(verId);
                                  };

                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                      phoneNumber: model.phoneNumber,
                                      // timeout: const Duration(seconds: 5),
                                      verificationCompleted: verified,
                                      verificationFailed: verificationfailed,
                                      codeSent: smsSent,
                                      codeAutoRetrievalTimeout: autoTimeout);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
        viewModelBuilder: () => LoginViewModel());
  }
}
