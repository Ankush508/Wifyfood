import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/KitchenHandlers/forgot_check_mobile.dart';
import 'package:wifyfood/KitchenHandlers/forgot_password_kitchen.dart';
import 'package:wifyfood/KitchenHandlers/login_kitchen.dart';
import 'package:wifyfood/KitchenView/forgototpscreen.dart';
import 'package:wifyfood/KitchenView/kitchendashboard.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/main.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String wifyfoodId;
  String mob, devId;
  String password;
  bool _obscureText = true, _isLoading = false;
  bool field1 = false, field2 = false, field3 = false;

  final _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    SetToken().getTokenIdLocal().then((value) {
      setState(() {
        devId = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).login,
          style: TextStyle(
              //color: Colors.grey[700],
              ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            BackgroundScreen(),
            Container(
              height: 812,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackgroundCircle(),
                ],
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
                  //height: Me,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                            'assets/svg/Vector Smart Object-6.svg'),
                      ),

                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            //color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width - 60,
                              height: 60,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: TextFormField(
                                  //initialValue: "123456",
                                  //keyboardType: TextInputType.number,
                                  // inputFormatters: [
                                  //   new LengthLimitingTextInputFormatter(6),
                                  // ],
                                  validator: (value) {
                                    if (field1 == true) {
                                      return 'Enter WifyId*';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    border: InputBorder.none,
                                    hintText: Languages.of(context).wifyId,
                                    labelText: Languages.of(context).wifyId,
                                    hintStyle: TextStyle(
                                      //fontSize: 18,
                                      color: Colors.grey[700],
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      wifyfoodId = value;
                                      if (value.isEmpty) {
                                        field1 = true;
                                      } else
                                        field1 = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (field2 == true) {
                                  return Languages.of(context).mobNo + '*';
                                } else if (value.length == 0) {
                                  return null;
                                } else if (value.length != 10) {
                                  return 'Enter Correct Mobile Number*';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).mobNo,
                                labelText: Languages.of(context).mobNo,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                mob = value;
                                if (value.isEmpty) {
                                  field2 = true;
                                } else
                                  field2 = false;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              //initialValue: "123456",
                              keyboardType: TextInputType.text,
                              // inputFormatters: [
                              //   new LengthLimitingTextInputFormatter(6),
                              // ],
                              validator: (value) {
                                if (field3 == true) {
                                  return 'Enter Password*';
                                }
                                return null;
                              },
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: 'Enter Password',
                                labelText: Languages.of(context).pass,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: _obscureText
                                      ? Icon(
                                          Icons.lock,
                                          size: 20,
                                          color: Colors.grey[700],
                                        )
                                      : Icon(
                                          Icons.lock_open,
                                          size: 20,
                                          color: Colors.grey[700],
                                        ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                  if (value.isEmpty) {
                                    field3 = true;
                                  } else
                                    field3 = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              if (mob == null || mob == "") {
                                field2 = true;
                              }
                            });
                            if (mob == null || mob == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Mobile Number is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              getForgotCheckMobileData(mob).then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (value.resCode == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotOTPScreen(mob),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                    msg: "${value.response}",
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg:
                                        "This Mobile is not Registered With us",
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         ForgotPasswordScreen(mob),
                              //   ),
                              // );
                            }
                          }
                        },
                        child: Text(
                          Languages.of(context).forgotPass,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      //Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              if (wifyfoodId == null || wifyfoodId == "") {
                                field1 = true;
                              } else if (mob == null || mob == "") {
                                field2 = true;
                              } else if (password == null || password == "") {
                                field3 = true;
                              }
                            });
                            if (wifyfoodId == null || wifyfoodId == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "WifyId is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (mob == null || mob == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Mobile Number is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (password == null || password == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Password is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              getLoginKitchen(mob, wifyfoodId, password, devId)
                                  .then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (value.status == 1) {
                                  var user = value.user;
                                  // print("User Id: ${user.userId}");
                                  SetKitchenId().setKitchenIdLocal(user.userId);
                                  SetKitchenId()
                                      .setKitchenMobLocal(user.mobile);
                                  PushNotification().initializeKitchen(context);
                                  Fluttertoast.showToast(
                                    msg: "Login Success",
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      settings: RouteSettings(
                                          name: "KitchenDashboard"),
                                      builder: (context) => KitchenDashboard(),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "${value.message}",
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                              });
                            }
                          }

                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => KitchenDashboard(),
                          //   ),
                          // );
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(224, 74, 34, 1),
                                Color.fromRGBO(219, 47, 35, 1)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              Languages.of(context).submit,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _isLoading ? loader(context) : Container(),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  final String mob;
  ForgotPasswordScreen(this.mob);
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String newPass1;
  String newPass2;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      body: Form(
        key: _formKey,
        // ignore: deprecated_member_use
        autovalidate: true,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/Layer 0.png',
                fit: BoxFit.fill,
              ),
            ),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.2, -40),
              child: Image.asset(
                'assets/Ellipse -20.png',
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
                  child: Column(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                            'assets/svg/Vector Smart Object-6.svg'),
                      ),
                      SizedBox(height: 50),
                      Text(
                        Languages.of(context).forgotPass,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 30),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return Languages.of(context).enterPass;
                                } else {
                                  return null;
                                }
                              },
                              obscureText: _obscureText1,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).enterNewPass,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obscureText1 = !_obscureText1;
                                    });
                                  },
                                  child: _obscureText1
                                      ? Icon(
                                          Icons.lock,
                                          size: 20,
                                          color: Colors.grey[700],
                                        )
                                      : Icon(
                                          Icons.lock_open,
                                          size: 20,
                                          color: Colors.grey[700],
                                        ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  newPass1 = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return Languages.of(context).enterPass;
                                  // } else if (newPass1 != newPass2) {
                                  //   return "Check Password Again";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: _obscureText2,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).conNewPass,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  },
                                  child: _obscureText2
                                      ? Icon(
                                          Icons.lock,
                                          size: 20,
                                          color: Colors.grey[700],
                                        )
                                      : Icon(
                                          Icons.lock_open,
                                          size: 20,
                                          color: Colors.grey[700],
                                        ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  newPass2 = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      //Spacer(),
                      SizedBox(height: 80),
                      //Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            if (newPass1 != newPass2) {
                              Fluttertoast.showToast(
                                msg: "Password didn't match",
                                fontSize: 20,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            } else {
                              getForgotPasswordKitchen(
                                      widget.mob, newPass1, newPass2)
                                  .then((value) {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                  msg: "${value.response}",
                                  fontSize: 20,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              });

                              //Navigator.pop(context);
                            }
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AddKitchenScreen(),
                          //   ),
                          // );
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(224, 74, 34, 1),
                                Color.fromRGBO(219, 47, 35, 1)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              Languages.of(context).reg,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //loader(context)
          ],
        ),
      ),
    );
  }
}

class SetKitchenId {
  static const KITCHEN_ID = "Kitchen_Id";

  setKitchenIdLocal(String kid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KITCHEN_ID, kid);
  }

  Future<String> getKitchenIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KITCHEN_ID);
  }

  Future removeKitchenIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(KITCHEN_ID);
  }

  static const KITCHEN_MOB = "Kitchen_Mobile";

  setKitchenMobLocal(String kmob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KITCHEN_MOB, kmob);
  }

  Future<String> getKitchenMobLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KITCHEN_MOB);
  }

  Future removeKitchenMobLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(KITCHEN_MOB);
  }
}
