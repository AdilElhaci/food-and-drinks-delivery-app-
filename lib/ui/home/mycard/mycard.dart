import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:fooddeliveryapp/ui/home/home/home.dart';
import 'package:kartal/kartal.dart';

class MyCard extends StatefulWidget {
  final bool v;

  const MyCard({Key key, this.v}) : super(key: key);
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  FirBaseServices call = FirBaseServices();
  bool _state;
  @override
  void initState() {
    super.initState();
    _state = widget.v;
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
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                padding: EdgeInsets.all(20),
                itemCount: 4,
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
                                    padding: EdgeInsets.all(20),
                                    child:
                                        Image.asset('assets/images/cola.png'))
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'data',
                                      style: context.textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '300ml',
                                      style: context.textTheme.headline5
                                          .copyWith(fontSize: 15),
                                    ),
                                  ],
                                )),
                            Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 110, top: 40),
                                      child: Text("4 TL",
                                          style: context.textTheme.headline6)),
                                  Container(
                                    padding: EdgeInsets.only(left: 70, top: 20),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              print('object');
                                            }),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '3',
                                          style: context.textTheme.headline5,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              print('object');
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
