import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenView/registeryourkitchenscreen.dart';
import 'package:wifyfood/KitchenView/signinscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';

enum _PositionItemType {
  // ignore: unused_field
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class SignInRegisterKitchenScreen extends StatefulWidget {
  @override
  _SignInRegisterKitchenScreenState createState() =>
      _SignInRegisterKitchenScreenState();
}

class _SignInRegisterKitchenScreenState
    extends State<SignInRegisterKitchenScreen> {
  String latitude = "", longitude = "";
  final List<_PositionItem> _positionItems = <_PositionItem>[];

  Future getLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == true) {
      // LocationPermission permission = await Geolocator.checkPermission();

      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((value) {
        print("$value");
        _positionItems.add(
          _PositionItem(
            _PositionItemType.position,
            value.toString(),
          ),
        );
        setState(() {
          latitude = value.latitude.toString();
          longitude = value.longitude.toString();
        });
        print("Latitude: $latitude");
        print("Longitude: $longitude");
      });
    } else {
      Fluttertoast.showToast(
        msg: "Turn on your GPS",
        fontSize: 20,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //alignment: Alignment.center,
        children: [
          Container(
            //color: Colors.amberAccent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: BackgroundScreen(),
                ),
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
          // Container(
          //   child: Column(
          //     children: [
          //       Expanded(
          //         flex: 2,
          //         child: Container(),
          //       ),
          //       Expanded(
          //         flex: 2,
          //         child: Padding(
          //           padding: const EdgeInsets.only(left: 25.0),
          //           child: Align(
          //             alignment: Alignment.bottomLeft,
          //             child: Image.asset(
          //               'assets/wify girl.png',
          //               scale: 1.3,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   child: Column(
          //     children: [
          //       Expanded(
          //         flex: 2,
          //         child: Container(),
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: Container(
          //           //color: Colors.black26,
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Image.asset(
          //               'assets/Group 671.png',
          //               fit: BoxFit.fill,
          //               //cacheHeight: 100,
          //               scale: 1,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.black26,
                    //height: MediaQuery.of(context).size.height * 0.3,
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                          'assets/svg/Vector Smart Object-6.svg'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      //color: Colors.black38,

                      ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
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
                                Languages.of(context).signin,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RegisterYourKitchenScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(245, 147, 33, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                Languages.of(context).regKitchen,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Transform.translate(
                      offset: Offset(0, 30),
                      child: Image.asset(
                        'assets/Group 2316.png',
                        fit: BoxFit.fill,
                      ),
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
