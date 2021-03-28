import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/model/order.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:fooddeliveryapp/ui/home/home/home.dart';
import 'package:kartal/kartal.dart';

class MyOrdersPage extends StatefulWidget {
  final String title;
  final bool v;
  const MyOrdersPage({Key key, this.title, this.v}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  FirBaseServices call = FirBaseServices();

  List<Order> requiredList = [];
  Future<void> getOrderList() async {
    requiredList = await call.getAllOrderList();
    setState(() {});
  }

  bool _state;
  @override
  void initState() {
    super.initState();
    getOrderList();

    _state = widget.v;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF5E1994),
      appBar: buildAppBarOrder(context),
      body: Container(
        child: Column(children: [
          Expanded(
            flex: 8,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              padding: EdgeInsets.all(20),
              itemCount: requiredList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFFC4C4C4),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: context.dynamicHeight(0.18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 150,
                              height: 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child:
                                  Image.network(requiredList[index].foodImage)),
                          Container(
                              padding: EdgeInsets.only(top: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    requiredList[index].orderStatus,
                                    style: context.textTheme.headline6
                                        .copyWith(fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      requiredList[index].returantName,
                                      style: context.textTheme.headline5
                                          .copyWith(fontSize: 20),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: Text(requiredList[index].ordered.toString(),
                                style: context.textTheme.headline6),
                          ),
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
            child: _state == true
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: context.dynamicHeight(0.05),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFffffff)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: context.highBorderRadius,
                          ))),
                      onPressed: () async {
                        UserModel user = await call.getUserData();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(userModel: user)),
                            (route) => false);
                      },
                      child: Text(
                        'Ana sayfaya git ',
                        style: context.textTheme.headline5,
                      ),
                    ),
                  )
                : Container(),
          )
        ]),
      ),
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
          'Orders',
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
}
