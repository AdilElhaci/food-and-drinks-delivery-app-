import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/constants/asset-files-url.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:fooddeliveryapp/ui/home/products/product_page.dart';
import 'package:fooddeliveryapp/ui/home/search/search.dart';
import 'package:kartal/kartal.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  FirBaseServices call = FirBaseServices();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
                          showCursor: false,
                          decoration: new InputDecoration(
                            hintText: "Search",
                          ),
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()),
                            );
                          }))
                ],
              )),
        ),
        body: Container(
          color: Color(0xFF5E1994),
          child: ListView(children: [
            Column(
              children: <Widget>[
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsPage(category: 'drink')),
                                (route) => false);
                          },
                          child: buildStackOrder(
                              'assets/images/drinks.png', 'Drinks'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsPage(category: 'fast_food')),
                                (route) => false);
                          },
                          child: buildStackOrder(
                              'assets/images/fast-food.png', 'Fast Food'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsPage(category: 'dessert')),
                                (route) => false);
                          },
                          child: buildStackOrder(
                              'assets/images/dessert.png', 'Dessert')),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductsPage(category: 'breakfast')),
                              (route) => false);
                        },
                        child: buildStackOrder(
                            'assets/images/breakfast.png', 'Breakfast'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsPage(category: 'meat')),
                                (route) => false);
                          },
                          child: buildStackOrder(
                              'assets/images/meat.png', 'Meat')),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  Stack buildStackOrder(String url, String title) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color(0xFFC4C4C4),
              child: Container(
                height: 120,
                width: 150,
              ),
            ),
            Positioned(
              top: -50,
              bottom: 50,
              child: Container(
                height: 150,
                width: 100,
                child: Image.asset(
                  url,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                child: Text(
                  title,
                  style: context.textTheme.headline5,
                ))
          ],
        ),
      ],
    );
  }
}
