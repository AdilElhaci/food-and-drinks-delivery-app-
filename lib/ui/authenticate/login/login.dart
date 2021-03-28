import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/components/widgets/buttons/elevated_button/page_button.dart';
import 'package:fooddeliveryapp/core/components/widgets/buttons/elevated_button/text_button.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:fooddeliveryapp/main.dart';
import 'package:fooddeliveryapp/ui/home/home/home.dart';
import 'package:kartal/kartal.dart';
import '../../../core/model/user.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _pageState = true;
  UserModel userModel = UserModel();
  TextEditingController _email = new TextEditingController();
  TextEditingController _fullName = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _rePassword = new TextEditingController();
  String p, rp;

  FirBaseServices call = FirBaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: login(context));
  }

  Container login(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 20, right: 20),
      color: Color(0xFF5E1994),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LogInElevatedButton(
                    color: Colors.white,
                    title: 'giriş yap ',
                    status: true,
                    onSelectedd: (pageState) {
                      setState(() {
                        clearTextEditingControllers();
                        _pageState = pageState;
                      });
                    }),
              ),
              SizedBox(height: 10, width: 30),
              Expanded(
                child: LogInElevatedButton(
                  color: Color(0xFFC4C4C4),
                  title: 'üye ol',
                  status: false,
                  onSelectedd: (pageState) {
                    setState(() {
                      clearTextEditingControllers();
                      _pageState = pageState;
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 80),
          _pageState ? singinForm(context) : signUpForm(context)
        ],
      ),
    );
  }

  Container signUpForm(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                padding: context.paddingLow,
                decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: TextFormField(
                    onChanged: (value) {
                      _fullName.text = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'yanlış soy isim';
                      } else {
                        return null;
                      }
                    },
                    decoration: new InputDecoration(
                        labelText: 'ad soyad', fillColor: Colors.white))),
            SizedBox(height: 30),
            Container(
                padding: context.paddingLow,
                decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'yanlış email';
                      } else {
                        return null;
                      }
                    },
                    controller: _email,
                    decoration: new InputDecoration(
                        labelText: 'Email', fillColor: Colors.white))),
            SizedBox(height: 30),
            Container(
                padding: context.paddingLow,
                decoration: BoxDecoration(
                  color: Color(0xFFC4C4C4),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextFormField(
                    onChanged: (value) {
                      _password.text = value;
                      p = value;
                    },
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'yanlış şifre';
                      } else {
                        return null;
                      }
                    },
                    decoration: new InputDecoration(
                      labelText: 'Şifre',
                      fillColor: Colors.white,
                    ))),
            SizedBox(height: 30),
            Container(
                padding: context.paddingLow,
                decoration: BoxDecoration(
                  color: Color(0xFFC4C4C4),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextFormField(
                    obscureText: true,
                    controller: _rePassword,
                    onChanged: (value) {
                      _rePassword.text = value;
                      rp = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 5 || rp.contains(p)) {
                        return 'yanlış şifre';
                      } else {
                        return null;
                      }
                    },
                    decoration: new InputDecoration(
                      labelText: 'tekrar şifre',
                      fillColor: Colors.white,
                    ))),
            SizedBox(height: 50),
            SizedBox(
              height: 60,
              width: 120,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: context.lowBorderRadius,
                    ))),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _signUpSubmit(context);
                  }
                },
                child: Text(
                  'Kayıt ol',
                  style: context.textTheme.headline6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form singinForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
              padding: context.paddingLow,
              decoration: BoxDecoration(
                color: Color(0xFFC4C4C4),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _email.text = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'yanlış email';
                    } else {
                      return null;
                    }
                  },
                  decoration: new InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.white,
                  ))),
          SizedBox(height: 50),
          Container(
              padding: context.paddingLow,
              decoration: BoxDecoration(
                color: Color(0xFFC4C4C4),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password.text = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Yanlış şifre';
                    } else {
                      return null;
                    }
                  },
                  decoration: new InputDecoration(
                    labelText: 'Şifre',
                    fillColor: Colors.white,
                  ))),
          SizedBox(height: 100),
          SizedBox(
            height: 60,
            width: 120,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: context.lowBorderRadius,
                  ))),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _signInSubmit(context);
                }
              },
              child: Text(
                'Giriş yap',
                style: context.textTheme.headline6,
              ),
            ),
          ),
          FlatButtonForgotPassword()
        ],
      ),
    );
  }

  SizedBox sizedBoxEnterRaisedButton(BuildContext context, String variable) {
    return SizedBox(
      height: 60,
      width: 120,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: context.lowBorderRadius,
            ))),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        },
        child: Text(
          variable,
          style: context.textTheme.headline6,
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> _signUpSubmit(BuildContext context) async {
    var result = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: _email.text, password: _password.text)
            .catchError((msg) {
      showFlutterToastMessage('Hata' + msg, context);
    }))
        .user;

    if (result != null) {
      userRef.child(result.uid);
      Map userDataMap = {
        "name": _fullName.text,
        "email": _email.text,
        "password": _password.text,
        "address": ' '
      };
      result.sendEmailVerification();
      userRef.child(result.uid).set(userDataMap);

      showFlutterToastMessage(
          'üye işlemi başarı ile gerçekleştirildi !', context);
    } else {
      showFlutterToastMessage('user oluştutururken hata oluştu', context);
    }
    setState(() {
      _pageState = !_pageState;
    });
  }

  showFlutterToastMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Tmm',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ));
  }

  clearTextEditingControllers() {
    _email.clear();
    _fullName.clear();
    _password.clear();
    _rePassword.clear();
  }

  Future<void> _signInSubmit(BuildContext context) async {
    bool respons = false;
    print(_email.text);
    print(_password.text);

    await call.signInSubmit(_email.text, _password.text).then(((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(userModel: value)),
          (route) => false);
    })).catchError((onError) {
      respons = true;
    });
    if (respons == true) {
      showFlutterToastMessage('Email veya şifre yanlış girildi', context);
    }
  }
}
