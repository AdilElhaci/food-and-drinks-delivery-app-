import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fooddeliveryapp/core/model/features.dart';
import 'package:fooddeliveryapp/core/model/foodmodel.dart';
import 'package:fooddeliveryapp/core/model/user.dart';

class FirBaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel userModel = UserModel();
  final dbUser = FirebaseDatabase.instance.reference().child("users");
  final dbFood = FirebaseDatabase.instance.reference().child("foods");

  Future<UserModel> signInSubmit(String email, String password) async {
    var result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (!result.user.emailVerified) {
      return null;
    } else if (result == null) {
      return null;
    } else {
      userModel = await getUserData();
      return userModel;
    }
  }

  Future<UserModel> getUserData() async {
    var response = _firebaseAuth.currentUser;
    String uid = response.uid;
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

  Future<dynamic> get userId async => _firebaseAuth.currentUser;

  Future<bool> updateUserData(String passowrd, String address) async {
    var user = await userId;
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

  Future<List<FoodModel>> getFoodList(String category) async {
    List<FoodModel> list = [];

    await dbFood.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var values = snapshot.value;

      for (var key in keys) {
        if (values[key]['category'] == category) {
          FoodModel food = new FoodModel();
          FoodFeatures foodFeactures = FoodFeatures();
          food.category = values[key]['category'];
          food.content = values[key]['content'];
          food.id = values[key]['id'];
          food.imgUrl = values[key]['img_url'];
          food.name = values[key]['name'];
          food.price = values[key]['price'];
          food.restaurantName = values[key]['restaurant_name'];
          foodFeactures.setId(values[key]['id']);
          foodFeactures.setPrice(values[key]['price']);
          foodFeactures.setNumber(0);
          food.obje = foodFeactures;
          list.add(food);
        }
      }
    });

    return list;
  }

  Future<List<FoodModel>> getAllFoodList() async {
    List<FoodModel> list = [];
    await dbFood.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var values = snapshot.value;
      for (var key in keys) {
        FoodModel food = new FoodModel();
        FoodFeatures foodFeactures = FoodFeatures();
        food.category = values[key]['category'];
        food.content = values[key]['content'];
        food.id = values[key]['id'];
        food.imgUrl = values[key]['img_url'];
        food.name = values[key]['name'];
        food.price = values[key]['price'];
        food.restaurantName = values[key]['restaurant_name'];
        foodFeactures.setId(values[key]['id']);
        foodFeactures.setNumber(0);
        foodFeactures.setPrice(values[key]['price']);
        food.obje = foodFeactures;
        list.add(food);
      }
    });

    return list;
  }
}
