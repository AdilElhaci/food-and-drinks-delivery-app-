import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/constants/asset-files-url.dart';
import 'package:fooddeliveryapp/core/model/foodmodel.dart';
import 'package:fooddeliveryapp/core/model/order.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:fooddeliveryapp/ui/home/home/home.dart';
import 'package:fooddeliveryapp/ui/home/mycard/mycard.dart';
import 'package:kartal/kartal.dart';

class ProductsPage extends StatefulWidget {
  final String category;
  ProductsPage({Key key, this.category}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  FirBaseServices call = FirBaseServices();
  UserModel userModel = UserModel();
  List<FoodModel> list = [];
  List<Order> requiredList = [];
  Future<UserModel> getUser() async => userModel = await call.getUserData();
  @override
  void initState() {
    super.initState();
    getUser();
    getListFood(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF5E1994),
        appBar: buildAppBarOrder(context),
        body: buildContainerBody(context));
  }

  Container buildContainerBody(BuildContext context) {
    return Container(
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 10,
          child: Container(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              padding: EdgeInsets.all(10),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFC4C4C4),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: context.dynamicHeight(0.18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: 80,
                                  height: 80,
                                  child: Image.network(list[index].imgUrl))
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
                                      list[index].name,
                                      style: context.textTheme.headline5
                                          .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    list[index].content,
                                    style: context.textTheme.headline5
                                        .copyWith(fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    list[index].restaurantName,
                                    style: context.textTheme.headline5.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Container(
                                    padding: EdgeInsets.only(left: 60, top: 20),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                            list[index].price.toString() +
                                                ' TL',
                                            style: context.textTheme.headline5),
                                      ),
                                    ])),
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
                                            if (list[index].obje.number >= 0) {
                                              list[index].obje.setNumber(
                                                  list[index].obje.number - 1);

                                              setState(() {});
                                            }

                                            int indexNumber;
                                            bool con = false;
                                            Order order = Order();
                                            order.foodId = list[index].id;
                                            order.orderStatus = 'ordered';
                                            order.ordered = 1;
                                            order.userId = userModel.id;
                                            for (int i = 0;
                                                i < requiredList.length;
                                                i++) {
                                              if (order.foodId.contains(
                                                  requiredList[i].foodId)) {
                                                con = true;
                                                indexNumber = i;
                                              }
                                            }
                                            if (con == true) {
                                              if (requiredList[indexNumber]
                                                      .ordered >=
                                                  1) {
                                                requiredList[indexNumber]
                                                    .ordered--;
                                              }
                                            } else {
                                              requiredList.add(order);
                                            }
                                            for (var item in requiredList) {
                                              print(item.foodId);
                                              print(item.ordered);
                                            }
                                          }),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        list[index].obje.number.toString(),
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
                                            list[index].obje.setNumber(
                                                list[index].obje.number + 1);
                                            setState(() {});
                                            int indexNumber;
                                            bool con = false;
                                            Order order = Order();
                                            order.foodId = list[index].id;
                                            order.orderStatus = 'ordered';
                                            order.ordered = 1;
                                            order.userId = userModel.id;
                                            for (int i = 0;
                                                i < requiredList.length;
                                                i++) {
                                              if (order.foodId.contains(
                                                  requiredList[i].foodId)) {
                                                con = true;
                                                indexNumber = i;
                                              }
                                            }
                                            if (con == true) {
                                              requiredList[indexNumber]
                                                  .ordered++;
                                            } else {
                                              requiredList.add(order);
                                            }
                                            for (var item in requiredList) {
                                              print(item.foodId);
                                              print(item.ordered);
                                            }
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
        Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  height: context.dynamicHeight(0.07),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFECB5FF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: context.highBorderRadius,
                        ))),
                    onPressed: () {
                      call.getUserData().then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(userModel: value)),
                            (route) => false);
                      });
                    },
                    child: Text(
                      'Back',
                      style: context.textTheme.headline6,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: context.dynamicHeight(0.07),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFECB5FF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: context.highBorderRadius,
                        ))),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCard(
                                    v: true,
                                  )),
                          (route) => false);
                    },
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(ImageAndIconsUrl.cardIcon),
                            Text(
                              'Go to My card',
                              style: context.textTheme.headline6
                                  .copyWith(fontSize: 14),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ))
      ]),
    );
  }

  AppBar buildAppBarOrder(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFC4C4C4),
      shape: ContinuousRectangleBorder(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(90.0),
          bottomRight: Radius.circular(90.0),
        ),
      ),
      title: Container(
        child: Center(
            child: Text(
          'Products',
          style:
              context.textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
        )),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
        ),
      ),
    );
  }

  Future getListFood(String category) async {
    list = await call.getFoodList(category);
    setState(() {});
  }
}
