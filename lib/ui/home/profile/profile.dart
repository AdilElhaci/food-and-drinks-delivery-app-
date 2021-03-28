import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/components/widgets/alert_dialogs/signout_alert.dart';
import 'package:fooddeliveryapp/core/model/user.dart';
import 'package:fooddeliveryapp/core/service/firebase_service/firebase_auth.dart';
import 'package:kartal/kartal.dart';

class ProfilePage extends StatefulWidget {
  final UserModel userModel;

  const ProfilePage({Key key, this.userModel}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String password = '';
  String address;
  String _pageTitle = 'profile';
  String _currentpassword;
  String _currentaddress;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirBaseServices call = FirBaseServices();
  @override
  void initState() {
    super.initState();

    password = widget.userModel.password;
    address = widget.userModel.address;

    _onLoading();
  }

  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;
      widget.userModel != null
          ? new Future.delayed(new Duration(seconds: 3), _login)
          : _loading = false;
    });
  }

  Future _login() async {
    setState(() {
      if (widget.userModel != null) _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userModel.name);
    return Scaffold(
      key: _scaffoldKey,
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
            _pageTitle,
            style: context.textTheme.headline5
                .copyWith(fontWeight: FontWeight.bold),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: context.paddingLow,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextFormField(
                          initialValue: widget.userModel.name,
                          readOnly: true,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: context.paddingLow,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextFormField(
                            initialValue: widget.userModel.address,
                            onChanged: (val) {
                              _currentpassword = val;
                            },
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length < 5 ||
                                  _currentpassword == password) {
                                return 'invalid address';
                              } else {
                                return null;
                              }
                            },
                            decoration: new InputDecoration(
                                errorBorder: InputBorder.none,
                                labelText: 'password',
                                labelStyle: TextStyle(height: 0),
                                fillColor: Colors.white)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: context.paddingLow,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextFormField(
                            initialValue: widget.userModel.address,
                            onChanged: (val) {
                              _currentaddress = val;
                            },
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length < 5 ||
                                  _currentaddress == address) {
                                return 'invalid address';
                              } else {
                                return null;
                              }
                            },
                            decoration: new InputDecoration(
                                errorBorder: InputBorder.none,
                                labelText: 'address',
                                labelStyle: TextStyle(height: 0),
                                fillColor: Colors.white)),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 250,
                        height: context.dynamicHeight(0.07),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green.shade200),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: context.highBorderRadius,
                              ))),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _updateUserData();
                            }
                          },
                          child: Text(
                            'Edit',
                            style: context.textTheme.headline5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 250,
                        height: context.dynamicHeight(0.07),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFECB5FF)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: context.highBorderRadius,
                              ))),
                          onPressed: () {
                            _showMyDialog();
                          },
                          child: Text(
                            'Logout',
                            style: context.textTheme.headline5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SignOutAlert();
        });
  }

  Future<void> _updateUserData() async {
    bool result = await call.updateUserData(_currentpassword, _currentaddress);
    if (result == true) {
      processdialog('The update process has succeeded');
    } else {
      processdialog('The update process has been failed');
    }
  }

  Future<void> processdialog(String messege) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(messege),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
