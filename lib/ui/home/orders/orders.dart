import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MyOrdersPage extends StatefulWidget {
  final String title;

  const MyOrdersPage({Key key, this.title}) : super(key: key);


  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF5E1994),
      appBar: buildAppBarOrder(context),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        padding: EdgeInsets.all(20),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                color: Color(0xFFC4C4C4),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: context.dynamicHeight(0.2),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(20),
                            child: Image.asset('assets/images/cola.png'))
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
                            SizedBox(
                              height: 10,
                            ),
                            Text('Resturant name'),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 80, top: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("4 TL", style: context.textTheme.headline6),
                            ]))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 50, top: 10),
                        child: Text('current :',
                            style: context.textTheme.headline6)),
                    Container(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text('preparing',
                            style: context.textTheme.headline6))
                  ],
                )
              ],
            ),
          );
        },
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
