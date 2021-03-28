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
                      'şifre unuttum'.toUpperCase(),
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
                                return 'yanlış giriş';
                              }
                              return null;
                            },
                            controller: _email,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "email giriniz",
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
                            "onayla",
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
                            "Geri",
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
    await _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .then((value) => {done(context, 'İşlem başarı ile gerçeklerşitirildi')})
        .onError((error, stackrace) => done(context,
            'İşlem gerçekleştirirken bir hata olustu lutfen bilgilerinizi kontrol edin'));
  }

  done(BuildContext contex, String mes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("messaj"),
          content: new Text(mes),
          actions: <Widget>[
            TextButton(
              child: Text("Giriş sayfasına git"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
            TextButton(
              child: Text("iptal"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
