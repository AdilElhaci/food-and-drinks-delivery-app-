import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/constants/asset-files-url.dart';
import 'package:fooddeliveryapp/core/model/foodmodel.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:kartal/kartal.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  SearchPage({Key key, this.userModel}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirBaseServices call = FirBaseServices();
  List<FoodModel> dataList = [];
  String str;
  int _number;
  @override
  void initState() {
    _number = 0;
    super.initState();
    getListFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF5E1994),
        appBar: buildAppBar(context),
        body: dataList == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : buildContainerBody(context));
  }

  Container buildContainerBody(BuildContext context) {
    return Container(
      child: Column(children: [
        Expanded(
          flex: 18,
          child: Container(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              padding: EdgeInsets.all(10),
              itemCount: dataList != null ? dataList.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(color: Color(0xFFC4C4C4), borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: context.dynamicHeight(0.18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(padding: EdgeInsets.only(left: 10), width: 80, height: 80, child: Image.network(dataList[index].imgUrl))
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 120,
                                    child: Text(
                                      dataList[index].name,
                                      style: context.textTheme.headline5.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    dataList[index].content,
                                    style: context.textTheme.headline5.copyWith(fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    dataList[index].restaurantName,
                                    style: context.textTheme.headline5.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Container(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                                padding: EdgeInsets.only(left: 60, top: 40),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(dataList[index].price.toString() + 'TL', style: context.textTheme.headline5),
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 30, top: 30),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        remove();
                                      }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _number.toString(),
                                    style: context.textTheme.headline5,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        add();
                                      }),
                                ],
                              ),
                            )
                          ]))
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future getListFood() async {
    dataList = await call.getAllFoodList();
  }

  void add() {
    _number++;

    setState(() {});
  }

  void remove() {
    if (_number > 0) _number--;
    setState(() {});
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Color(0xFFC4C4C4),
            borderRadius: BorderRadius.all(Radius.circular(10.0) //
                ),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              Image.asset(ImageAndIconsUrl.searchIcon),
              SizedBox(width: 10),
              Expanded(
                  child: TextField(
                      onChanged: (value) {
                        searchMethod(value);
                        dataList.clear();
                      },
                      decoration: new InputDecoration(
                        hintText: "Search",
                      ),
                      onTap: () {}))
            ],
          )),
    );
  }

  void searchMethod(String str) {
    DatabaseReference searchRef = FirebaseDatabase.instance.reference().child('foods');
    searchRef.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in keys) {
        FoodModel food = new FoodModel();
        food.category = values[key]['category'];
        food.content = values[key]['content'];
        food.id = values[key]['id'];
        food.imgUrl = values[key]['img_url'];
        food.name = values[key]['name'];
        food.price = values[key]['price'];
        food.restaurantName = values[key]['restaurant_name'];
        if (values[key]['name'].contains(str)) {
          print(values[key]['name']);
          dataList.add(food);
        }
      }
      Timer(Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }
}
