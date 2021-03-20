import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/constants/asset-files-url.dart';
import 'package:fooddeliveryapp/core/model/user.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  SearchPage({Key key, this.userModel}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF5E1994),
      appBar: buildAppBar(context),
      body: Center(),
    );
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
                      decoration: new InputDecoration(
                        hintText: "Search",
                      ),
                      showCursor: false,
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      }))
            ],
          )),
    );
  }
}
