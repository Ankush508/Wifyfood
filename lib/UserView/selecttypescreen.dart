//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Helper/get_current_location.dart';
import 'package:wifyfood/KitchenView/kitchendashboard.dart';
import 'package:wifyfood/KitchenView/signinregisterkitchenscreen.dart';
import 'package:wifyfood/KitchenView/signinscreen.dart';
import 'package:wifyfood/UserView/homescreen.dart';
import 'package:wifyfood/UserView/otpverificationscreen.dart';
import 'package:wifyfood/UserView/registrationscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wifyfood/UserView/userdashboard.dart';

// enum _PositionItemType {
//   // ignore: unused_field
//   permission,
//   position,
// }

// class _PositionItem {
//   _PositionItem(this.type, this.displayValue);

//   final _PositionItemType type;
//   final String displayValue;
// }

class SelectTypeScreen extends StatefulWidget {
  final String userId;
  SelectTypeScreen(this.userId);
  @override
  _SelectTypeScreenState createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  String latitude = "", longitude = "";

  @override
  void initState() {
    CurrentLocation().getCurrentLatLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.grey[700],
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
                  flex: 6,
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
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.black12,
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                          'assets/svg/Vector Smart Object-6.svg'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.black26,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            SetKitchenId().getKitchenIdLocal().then((value) {
                              if (value == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SignInRegisterKitchenScreen(),
                                  ),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    settings:
                                        RouteSettings(name: "KitchenDashboard"),
                                    builder: (context) => KitchenDashboard(),
                                  ),
                                );
                              }
                            });
                          },
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.28,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset('assets/svg/kitchen.svg'),
                                  Text(
                                    Languages.of(context).register,
                                    style: TextStyle(
                                      //color: Colors.grey[700],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    //maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Geolocator.checkPermission().then((value) async {
                              if (value == LocationPermission.always ||
                                  value == LocationPermission.whileInUse) {
                                await Geolocator.isLocationServiceEnabled()
                                    .then((value) {
                                  print("$value");
                                  if (value == false) {
                                    Geolocator.getCurrentPosition()
                                        .then((value) {
                                      try {
                                        if (value.latitude != null) {
                                          SetUserId()
                                              .getUserIdLocal()
                                              .then((value) {
                                            if (value == null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationScreen(),
                                                ),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      /*HomeScreen(),*/ UserDashboardScreen(
                                                          widget.userId),
                                                ),
                                              );
                                            }
                                          });
                                        } else {
                                          Geolocator.getCurrentPosition();
                                        }
                                      } catch (e) {
                                        Geolocator.getCurrentPosition();
                                      }
                                    });
                                  } else {
                                    Geolocator.getCurrentPosition()
                                        .then((value) {
                                      try {
                                        if (value.latitude != null) {
                                          SetUserId()
                                              .getUserIdLocal()
                                              .then((value) {
                                            if (value == null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationScreen(),
                                                ),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      /*HomeScreen(widget.userId),*/ UserDashboardScreen(
                                                          widget.userId),
                                                ),
                                              );
                                            }
                                          });
                                        } else {
                                          Geolocator.getCurrentPosition();
                                        }
                                      } catch (e) {
                                        Geolocator.getCurrentPosition();
                                      }
                                    });
                                  }
                                });
                              } else if (value == LocationPermission.denied) {
                                print("denied");
                                Geolocator.requestPermission();
                                // await Geolocator.openLocationSettings();
                              } else if (value ==
                                  LocationPermission.deniedForever) {
                                print("denied forever");
                                //	Fluttertoast.showToast(
                                // msg: "Please enable location services",
                                // fontSize: 20,
                                // textColor: Colors.white,
                                // backgroundColor: Colors.blue,
                                // toastLength: Toast.LENGTH_SHORT,
                                //  gravity: ToastGravity.CENTER,
                                // 	);
                                await Geolocator.openAppSettings();
                              }
                            });
                            // await _loc.hasPermission().then((value) async {
                            //   if (value == PermissionStatus.granted) {
                            //     print("Permission: Granted");
                            //     await _loc.serviceEnabled().then((value) async {
                            //       print("serviceEnabled: $value");
                            //       if (value == true) {
                            //         await _loc.requestService().then((value) {
                            //           print("requestService: $value");
                            //           if (value == true) {
                            //             SetUserId()
                            //                 .getUserIdLocal()
                            //                 .then((value) {
                            //               if (value == null) {
                            //                 Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         RegistrationScreen(),
                            //                   ),
                            //                 );
                            //               } else {
                            //                 Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         HomeScreen(),
                            //                   ),
                            //                 );
                            //               }
                            //             });
                            //           }
                            //         });
                            //       } else {
                            //         print("1");
                            //         _loc.requestService();
                            //         print("2");
                            //       }
                            //     });
                            //   } else if (value == PermissionStatus.denied) {
                            //     print("Permission: Denied");
                            //     // _loc.requestService();
                            //     _loc.requestPermission();

                            //     _loc.serviceEnabled();
                            //   } else if (value ==
                            //       PermissionStatus.deniedForever) {
                            //     print("Permission: Denied Gorever");
                            //     _loc.requestPermission();
                            //     _loc.requestService();
                            //   }
                            // });
                          },
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.28,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg/food orders.svg'),
                                  Text(
                                    Languages.of(context).order,
                                    style: TextStyle(
                                      //color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
