import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/constants/asset-files-url.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/ui/home/home/dashboard.dart';
import 'package:fooddeliveryapp/ui/home/mycard/mycard.dart';
import 'package:fooddeliveryapp/ui/home/orders/orders.dart';
import 'package:fooddeliveryapp/ui/home/profile/profile.dart';
import 'package:fooddeliveryapp/ui/home/search/search.dart';

class Home extends StatefulWidget {
  final UserModel userModel;
  Home({Key key, this.userModel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    DashBoard(),
    ProfilePage(),
    MyOrdersPage(),
    SearchPage(),
    MyCard(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5E1994),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Container(
        width: 100,
        height: 80,
        child: FloatingActionButton(
          child: Icon(
            Icons.home,
            size: 50,
            color: Color(0xFF5E1994),
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              currentScreen = DashBoard();
              currentTab = 0;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentScreen = ProfilePage(
                              userModel: widget.userModel,
                            );
                            currentTab = 1;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: new Image.asset(
                              ImageAndIconsUrl.profileIcon,
                              color: currentTab == 1
                                  ? Color(0xFF5E1994)
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                currentScreen = ProfilePage(
                                  userModel: widget.userModel,
                                );
                                currentTab = 1;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentScreen = MyOrdersPage();
                            currentTab = 2;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: new Image.asset(
                              ImageAndIconsUrl.timerIcon,
                              color: currentTab == 2
                                  ? Color(0xFF5E1994)
                                  : Colors.grey,
                            ),
                            onPressed: null,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentScreen = SearchPage();
                            currentTab = 3;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: new Image.asset(
                              ImageAndIconsUrl.searchIcon,
                              color: currentTab == 3
                                  ? Color(0xFF5E1994)
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                currentScreen = SearchPage();
                                currentTab = 3;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentScreen = MyCard(
                              v: false,
                            );
                            currentTab = 4;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: new Image.asset(
                              ImageAndIconsUrl.cardIcon,
                              color: currentTab == 4
                                  ? Color(0xFF5E1994)
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                currentScreen = MyCard(
                                  v: false,
                                );
                                currentTab = 4;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
