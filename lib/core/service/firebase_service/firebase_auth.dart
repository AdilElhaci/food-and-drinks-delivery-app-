import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fooddeliveryapp/core/model/foodmodel.dart';
import 'package:fooddeliveryapp/core/model/user.dart';

class FirBaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel userModel = UserModel();
  final dbUser = FirebaseDatabase.instance.reference().child("users");
  final dbFood = FirebaseDatabase.instance.reference().child("foods");

  Future<UserModel> signInSubmit(String email, String password) async {
    String uid;

    var result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (!result.user.isEmailVerified) {
      return null;
    } else if (result == null) {
      return null;
    } else {
      uid = result.user.uid;

      userModel = await getUserData(uid);
      return userModel;
    }
  }

  Future<UserModel> getUserData(String uid) async {
    UserModel user = UserModel();
    bool respons = false;
    await dbUser.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        if (uid == key) {
          user.name = values['name'];
          user.email = values['email'];
          user.address = values['address'];
          user.password = values['password'];
          respons = true;
        }
      });
    });
    if (respons == true) {
      return user;
    } else {
      return null;
    }
  }

  Future<FirebaseUser> get userId async => await _firebaseAuth.currentUser();

  Future<bool> updateUserData(String passowrd, String address) async {
    final FirebaseUser user = await userId;
    String uid = user.uid;

    bool result = false;
    try {
      Map<String, Object> createDoc = new HashMap();
      createDoc['password'] = passowrd;
      createDoc['address'] = address;

      await dbUser
          .child(uid)
          .update(createDoc)
          .then((value) => {result = true});
    } catch (e) {
      print(e.toString());
    }
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<FoodModel>> getFoodList() async {
    List<FoodModel> list = [];

    await dbFood.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;

      data.forEach((key, value) {
        FoodModel food = new FoodModel();
        food.category = value['category'];
        food.content = value['content'];
        food.id = value['id'];
        food.imgUrl = value['img_url'];
        food.name = value['name'];
        food.price = value['price'];

        food.restaurantName = value['restaurant_name'];

        list.add(food);
      });
    });

    return list;
  }
}
