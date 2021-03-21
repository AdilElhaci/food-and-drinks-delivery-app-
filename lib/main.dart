import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/ui/authenticate/login/forgot_password.dart';
import 'package:fooddeliveryapp/ui/authenticate/login/login.dart';
import 'package:fooddeliveryapp/ui/home/home/home.dart';
import 'package:fooddeliveryapp/ui/home/products/product_page.dart';
import 'package:fooddeliveryapp/ui/home/profile/profile.dart';

void main() {
  runApp(MyApp());
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF5E1994),
      ),
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/profile': (context) => ProfilePage(),
        '/login': (context) => Login(),
        '/': (context) => Home(),
        '/product': (context) => ProductsPage(),
        '/home': (context) => Home(),
        '/forgotpassword': (context) => ForgotPassword(),
      },
    );
  }
}
