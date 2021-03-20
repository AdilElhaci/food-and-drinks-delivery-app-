import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String password;
  String name;
  String id;
  String email;
  String address;

  UserModel({this.password, this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }

  UserModel.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        name = snapshot.value["name"] ?? '',
        password = snapshot.value["password"] ?? '',
        address = snapshot.value["address"] ?? '',
        email = snapshot.value["name"] ?? '';
}
