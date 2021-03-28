import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:fooddeliveryapp/ui/authenticate/login/login.dart';
import 'package:fooddeliveryapp/ui/home/home/home.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => new _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isLoggedIn;

  FirBaseServices call = FirBaseServices();
  UserModel userModel = UserModel();
  Future<UserModel> getUser() async => userModel = await call.getUserData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (userModel != null) {
            return Home(userModel: userModel);
          } else if (snapshot.hasError) {
            return Login();
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
