import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/ui/authenticate/login/forgot_password.dart';
import 'package:kartal/kartal.dart';

class FlatButtonForgotPassword extends StatelessWidget {
  const FlatButtonForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        child: Text('Forgot password?',
            style: context.textTheme.headline6
                .copyWith(color: Color(0xFFC4C4C4))));
  }
}
