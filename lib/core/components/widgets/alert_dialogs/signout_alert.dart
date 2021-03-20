import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOutAlert extends StatelessWidget {
  const SignOutAlert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Log out'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Are you sure for sign out from app ?'),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Approve'),
          onPressed: () async {
            _signOut(context);
          },
        ),
        ElevatedButton(
          child: Text('canel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
Future<void> _signOut(BuildContext context) async {
  await _firebaseAuth.signOut();

  Navigator.pushNamedAndRemoveUntil(
      context, "/login", (Route<dynamic> route) => false);
}
