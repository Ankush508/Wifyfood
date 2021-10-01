import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/check_otp.dart';
import 'package:wifyfood/KitchenHandlers/resend_otp_kitchen.dart';
import 'package:wifyfood/KitchenView/addkitchenscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserHandlers/city_list.dart';

class EnterOTPScreen extends StatefulWidget {
  final String ownerName,
      dob,
      kitchenName,
      cuisine,
      email,
      mobile,
      password,
      logo;
  final List<City> cities;
  EnterOTPScreen(this.ownerName, this.dob, this.kitchenName, this.cuisine,
      this.email, this.mobile, this.password, this.logo, this.cities);
  @override
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  Timer timer;
  int start = 10;
  bool resendOtp = false;

  String otp;
  final _formKey = new GlobalKey<FormState>();

  void startTimer() {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).verify,
          style: TextStyle(
              //color: Colors.grey[700],
              ),
        ),
        actions: [],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            BackgroundScreen(),
            BackgroundCircle(),
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
                        Languages.of(context).enterOTP,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 30),
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(4),
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return Languages.of(context).enterOtp + '*';
                                } else if (value.length == 4) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).enterOtp,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  otp = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      resendOtp
                          ? InkWell(
                              onTap: () {
                                getResendOtpKitchenData(widget.mobile)
                                    .then((value) {
                                  Fluttertoast.showToast(
                                    msg: "${value.otp}",
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                });
                              },
                              child: Text(
                                Languages.of(context).resendOtp,
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : Text(
                              '$start ' + Languages.of(context).sec,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                      //Spacer(),
                      SizedBox(height: 80),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            getOtpVerifyData(widget.mobile, otp).then((value) {
                              if (value.status == 1) {
                                Fluttertoast.showToast(
                                  msg: "${value.message}",
                                  fontSize: 20,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  toastLength: Toast.LENGTH_LONG,
                                );
                                var res = value.response;
                                print('UserId: ${res.userId}');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddKitchenScreen(
                                        widget.ownerName,
                                        widget.dob,
                                        widget.kitchenName,
                                        widget.cuisine,
                                        widget.email,
                                        widget.mobile,
                                        widget.password,
                                        widget.logo,
                                        widget.cities),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Incorrect Otp",
                                  fontSize: 20,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              }
                            });
                          }
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            // color: Colors.red[600],
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
                              Languages.of(context).proceed,
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
          ],
        ),
      ),
    );
  }
}
