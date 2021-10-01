import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/UserHandlers/check_otp.dart';
import 'package:wifyfood/UserHandlers/resend_otp.dart';
import 'package:wifyfood/UserHandlers/user_profile.dart';
import 'package:wifyfood/UserView/initialprofilescreen.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserView/userdashboard.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobNum;
  OtpVerificationScreen(this.mobNum);
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otpNum1, otpNum2, otpNum3, otpNum4;
  int start;
  bool resendOtp;
  Timer timer;
  void startTimer() {
    setState(() {
      start = 60; // Resend Otp timer set for 60 seconds
      resendOtp = false;
    });
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        timer.cancel();
        setState(() {
          resendOtp = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).otpVerification,
          style: TextStyle(
              //color: Colors.grey[700],
              ),
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.red,
            ),
          ),
          Container(
            //color: Colors.amberAccent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: BackgroundScreen(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  child: BackgroundCircle(),
                ),
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
          SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.black26,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                          'assets/svg/Vector Smart Object-6.svg'),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //       //color: Colors.black45,
                //       ),
                // ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red[700],
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Center(
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    autofocus: true,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    //showCursor: false,
                                    readOnly: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      otpNum1 = value;
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      } else if (value.length == 0) {
                                        //FocusScope.of(context).previousFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red[700],
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Center(
                                  child: TextField(
                                    cursorColor: Colors.white,
                                    autofocus: true,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    //maxLength: 1,
                                    //showCursor: false,
                                    readOnly: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      otpNum2 = value;
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      } else if (value.length == 0) {
                                        FocusScope.of(context).previousFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red[700],
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Center(
                                  child: TextField(
                                    cursorColor: Colors.white,
                                    autofocus: true,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    //maxLength: 1,
                                    //showCursor: false,
                                    readOnly: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      otpNum3 = value;
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      } else if (value.length == 0) {
                                        FocusScope.of(context).previousFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red[700],
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Center(
                                  child: TextField(
                                    cursorColor: Colors.white,
                                    autofocus: true,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    //maxLength: 1,
                                    //showCursor: false,
                                    readOnly: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      otpNum4 = value;
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      } else if (value.length == 0) {
                                        FocusScope.of(context).previousFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Languages.of(context).didntRecieve,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5),
                          resendOtp
                              ? InkWell(
                                  onTap: () {
                                    print("Resend otp clicked");
                                    getResendOtpData(widget.mobNum)
                                        .then((value) {
                                      print("Resend otp callback");
                                      if (value.responseCode == 0) {
                                        Fluttertoast.showToast(
                                          msg: "${value.response}",
                                          fontSize: 20,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.blue,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      } else {
                                        print("Resent Otp: ${value.otp}");
                                      }
                                    });
                                    startTimer();
                                  },
                                  child: Text(
                                    Languages.of(context).resend,
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : Text(
                                  '$start ' + Languages.of(context).sec,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          getOtpData(widget.mobNum,
                                  "$otpNum1$otpNum2$otpNum3$otpNum4")
                              .then((value) {
                            //print("OTP: $otpNum1$otpNum2$otpNum3$otpNum4");

                            if (value.status == 1) {
                              SetUserId().setUserIdLocal(value.response.userId);
                              PushNotification().initialize();
                              Fluttertoast.showToast(
                                msg: "${value.message}",
                                fontSize: 20,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                              );
                              var res = value.response;
                              //print('UserId: ${res.userId}');
                              getProfileData(res.userId).then((value) {
                                var res = value.response;
                                if (res.firstName == "") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          InitialProfileScreen(res.userId),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => /*HomeScreen()*/ UserDashboardScreen(
                                              res.userId),
                                    ),
                                  );
                                }
                              });
                            } else {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         InitialProfileScreen("22"),
                              //   ),
                              // );
                              Fluttertoast.showToast(
                                msg: "OTP does not match",
                                fontSize: 20,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                              );
                            }
                          });
                        },
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            //color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Center(
                                      child: Text(
                                        Languages.of(context).verify,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Image.asset(
                                    'assets/Icon material-done-red.png',
                                    scale: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SetUserId {
  static const USER_ID = "User_Id";

  setUserIdLocal(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, uid);
  }

  Future<String> getUserIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_ID);
  }

  Future removeUserIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(USER_ID);
  }
}

// class SaveUserId{

// }
