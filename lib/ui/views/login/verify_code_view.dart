import 'package:daily_quotes/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VerifyCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => null,
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Sms code',
                    ),
                    onChanged: (value) {
                      model.setSmsCode(value);
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('VERIFY'),
                    onPressed: () {
                      print('VerificationId: ');
                      // model.verifyCode();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
