import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/ui/authenticate/login/login.dart';
import 'package:kartal/kartal.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [Color(0xFF5E1994), Colors.deepPurple[100]]),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: height * 0.15,
            ),
            Container(
                margin: EdgeInsets.only(top: height * 0.15),
                height: height * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: ListView(
                  children: [
                    Text(
                      'Forgot Password'.toUpperCase(),
                      style: context.textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                      child: Container(
                        height: 1,
                        width: width * 0.7,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Text is empty or invalid';
                              }
                              return null;
                            },
                            controller: _email,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Enter you Email",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.solid,
                                        color: Color(0xFF5E1994))),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.solid,
                                        color: Color(0xFF5E1994))),
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.all(12))),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            resetPassword(_email.text, context);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: new LinearGradient(colors: [
                                Color(0xFF5E1994),
                                Colors.deepPurple[100]
                              ]),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0xFF5E1994),
                                    offset: Offset(2, 2))
                              ]),
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.7),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: new LinearGradient(colors: [
                                Colors.deepPurple[100],
                                Color(0xFF5E1994)
                              ]),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0xFF5E1994),
                                    offset: Offset(2, 2))
                              ]),
                          child: Text(
                            "Go back",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.7),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future resetPassword(String email, BuildContext contex) async {
    var result = _firebaseAuth.sendPasswordResetEmail(email: email);
    result.then((value) => () {}).catchError((onError) {
      done(contex, onError);
    });
    if (result != null) {
      result.whenComplete(
          () => {done(context, 'Your process has been done successfully')});
    }
  }

  showFlutterToastMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('snack'),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () {},
      ),
    ));
  }

  done(BuildContext contex, String mes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Message"),
          content: new Text(mes),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Go to Login page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
