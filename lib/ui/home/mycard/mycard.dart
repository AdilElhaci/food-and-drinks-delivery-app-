import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/model/order.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:fooddeliveryapp/ui/home/home/home.dart';
import 'package:kartal/kartal.dart';

class MyCard extends StatefulWidget {
  List<Order> requiredList;
  final bool v;

  MyCard({Key key, this.v, this.requiredList}) : super(key: key);
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  FirBaseServices call = FirBaseServices();
  List<Order> itemlist = [];
  bool _state;
  @override
  void initState() {
    super.initState();
    _state = widget.v;
    itemlist = widget.requiredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF5E1994),
        appBar: AppBar(
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
              'My Card',
              style: context.textTheme.headline5
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(
                      100) //                 <--- border radius here
                  ),
            ),
          ),
        ),
        body: Container(
            child: Column(children: [
          Expanded(
            flex: 9,
            child: Container(
              child: itemlist == null
                  ? Center(
                      child: Text(
                        'sepet bos',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      padding: EdgeInsets.all(20),
                      itemCount: itemlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 20, right: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFFC4C4C4),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: context.dynamicHeight(0.18),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 150,
                                      height: 100,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Image.network(
                                          itemlist[index].foodImage)),
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 20, right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'data',
                                            style: context.textTheme.headline6
                                                .copyWith(fontSize: 25),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '300ml',
                                            style: context.textTheme.headline5
                                                .copyWith(fontSize: 18),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 20),
                                    child: Column(children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade300,
                                          ),
                                          onPressed: () {
                                            itemlist.removeAt(index);
                                            setState(() {});
                                          }),
                                      Text(itemlist[index].ordered.toString(),
                                          style: context.textTheme.headline6),
                                    ]),
                                  ),
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
              flex: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 150,
                    height: context.dynamicHeight(0.06),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ))),
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.only(top: 10, right: 15),
                        child: Text(
                          'Total: ' + '15',
                          style: context.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: context.dynamicHeight(0.07),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFECB5FF)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: context.highBorderRadius,
                          ))),
                      onPressed: () {},
                      child: Text(
                        'order',
                        style: context.textTheme.headline5,
                      ),
                    ),
                  ),
                  _state == true
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: context.dynamicHeight(0.07),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFFffffff)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: context.highBorderRadius,
                                ))),
                            onPressed: () async {
                              UserModel user = await call.getUserData();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Home(userModel: user)),
                                  (route) => false);
                            },
                            child: Text(
                              'go to home ',
                              style: context.textTheme.headline5,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ))
        ])));
  }
}
