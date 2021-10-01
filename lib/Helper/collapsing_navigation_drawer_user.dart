import 'dart:convert';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Language/locale_constant.dart';
import 'package:wifyfood/UserView/orderhistoryscreen.dart';
import 'package:wifyfood/UserView/manageorderscreen.dart';
import 'package:wifyfood/UserView/otpverificationscreen.dart';
import 'package:wifyfood/UserView/selecttypescreen.dart';
import 'package:wifyfood/UserView/paymentlistscreen.dart';
import 'package:wifyfood/UserView/settingsscreen.dart';
import 'package:wifyfood/UserView/selectlanguagescreen.dart';
import 'package:wifyfood/main.dart';
import 'package:provider/provider.dart';
import 'package:wifyfood/Language/text_keys.dart';

class CollapsingNavigationDrawerUser extends StatefulWidget {
  final String userId, pic, fName, lName, cityId;
  final List<String> address;
  CollapsingNavigationDrawerUser(
      this.userId, this.address, this.pic, this.fName, this.lName, this.cityId);
  @override
  _CollapsingNavigationDrawerUserState createState() =>
      _CollapsingNavigationDrawerUserState();
}

class _CollapsingNavigationDrawerUserState
    extends State<CollapsingNavigationDrawerUser> {
  var pic;
  bool isLangArabic = false;
  Widget profileImage(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(100),
      child: CircleAvatar(
        radius: 58,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Colors.white,
          backgroundImage: MemoryImage(bytes),
        ),
      ),
    );
  }

  @override
  void initState() {
    pic = profileImage(widget.pic);

    getLocale().then((value) {
      print("Locale: $value");
      if (value == Locale('ar')) {
        setState(() {
          isLangArabic = true;
        });
        print("isLangArabic: $isLangArabic");
      }
    });
    // getProfileData(widget.userId).then((value) {
    //   setState(() {
    //     firstName = value.response.firstName;
    //     lastName = value.response.lastName;
    //     profilePic = value.response.image;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    bool _isNightMode = themeChange.darkTheme;
    return Stack(
      alignment: isLangArabic ? Alignment.centerLeft : Alignment.centerRight,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(isLangArabic ? math.pi : 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/33.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isLangArabic ? math.pi : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 40),
                  Container(
                    // color: Colors.black12,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 25),
                            pic,
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: isLangArabic
                              ? const EdgeInsets.only(right: 20.0)
                              : const EdgeInsets.only(left: 20.0),
                          child: Container(
                            // color: Colors.black12,
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            child: Text(
                              '${widget.fName} ' + '${widget.lName}',
                              // "ackab jsn jabuavj ajbb",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              // textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0),
                  Container(
                    // color: Colors.black26,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg/Vector Smart Object-2.svg'),
                                SizedBox(width: 20.0),
                                Text(
                                  Languages.of(context).entry1,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderHistoryScreen(widget.userId),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/svg/order history.svg',
                                  height: 25,
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  Languages.of(context).entry2,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ManageOrderScreen(widget.userId),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset('assets/svg/manage order.svg'),
                                SizedBox(width: 20.0),
                                Text(
                                  Languages.of(context).entry3,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsScreen(
                                    widget.userId,
                                    widget.address,
                                    widget.cityId),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg/Vector Smart Object-5.svg'),
                                SizedBox(width: 20.0),
                                Text(
                                  Languages.of(context).entry4,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/svg/dark theme.svg',
                                height: 25,
                              ),
                              SizedBox(width: 16.0),
                              Text(
                                Languages.of(context).entry5,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isNightMode = !_isNightMode;
                                    if (_isNightMode == true) {
                                      themeChange.darkTheme = _isNightMode;
                                    } else if (_isNightMode == false) {
                                      themeChange.darkTheme = _isNightMode;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 65,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey[300],
                                  ),
                                  child: _isNightMode
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                Languages.of(context).oN,
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                Languages.of(context).off,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
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
                        // Divider(
                        //   thickness: 1.5,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PaymentListScreen(widget.userId),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg/Vector Smart Object-3.svg'),
                                SizedBox(width: 20.0),
                                Text(
                                  Languages.of(context).entry6,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Divider(
                        //   thickness: 1.5,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectLanguageScreen(),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg/Vector Smart Object-1.svg'),
                                SizedBox(width: 20.0),
                                Text(
                                  Languages.of(context).entry7,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Divider(
                        //   thickness: 1.5,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => MyCampaignScreen(),
                            //   ),
                            // );
                            SetUserId().removeUserIdLocal();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SelectTypeScreen(widget.userId),
                                ));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SelectTypeScreen(),
                            //   ),
                            // );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg/Vector Smart Object-4.svg'),
                                SizedBox(width: 20.0),
                                Text(
                                  Languages.of(context).entry8,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Divider(
                        //   thickness: 1.5,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 3, size.height);
    path.quadraticBezierTo(size.width, size.height / 2, size.width / 3, 0);
    // path.lineTo(size.height, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 80);
//     path.quadraticBezierTo(
//         size.width / 2, size.height, size.width, size.height - 80);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
