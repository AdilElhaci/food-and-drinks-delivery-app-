import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/constants/asset-files-url.dart';
import 'package:fooddeliveryapp/core/model/foodmodel.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:kartal/kartal.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  FirBaseServices call = FirBaseServices();
  List<FoodModel> list = [];

  @override
  void initState() {
    super.initState();
    getListFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF5E1994),
        appBar: buildAppBarOrder(context),
        body: FutureBuilder(
            future: getListFood(),
            builder: (BuildContext context, snapshot) {
              return buildContainerBody(context);
            }));
  }

  Container buildContainerBody(BuildContext context) {
    return Container(
      child: Column(children: [
        Expanded(
          //To Do For Categories
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 10,
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
                height: context.dynamicHeight(0.15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(list[index].imgUrl))
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index].name,
                                  style: context.textTheme.headline6,
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
                                Text(list[index].restaurantName),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 100, top: 20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(list[index].content,
                                      style: context.textTheme.headline6),
                                  IconButton(
                                      icon: Image.asset(
                                          ImageAndIconsUrl.cardIcon),
                                      onPressed: () {})
                                ]))
                      ],
                    ),
                  ],
                ),
              );
            },
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
                      Navigator.pop(context);
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
                    onPressed: () {},
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
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                  100) //                 <--- border radius here
              ),
        ),
      ),
    );
  }

  Future getListFood() async {
    list = await call.getFoodList();

    setState(() {
      print(list.length);
    });
  }
}
