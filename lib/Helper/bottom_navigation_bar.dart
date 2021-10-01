import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:wifyfood/Helper/get_current_location.dart';
import 'package:wifyfood/UserHandlers/track_order_home.dart';
import 'package:wifyfood/UserView/blogscreen.dart';
import 'package:wifyfood/UserView/homescreen.dart';
import 'package:wifyfood/UserView/myaccountscreen.dart';
import 'package:wifyfood/UserView/newkitchen.dart';
import 'package:wifyfood/UserView/otpverificationscreen.dart';
import 'package:wifyfood/UserView/trackorderscreenhome.dart';

class BottomBar extends StatefulWidget {
  final String str1, str2, str3, str4, str5, cityId;
  final List<String> address;
  final List<bool> click;
  BottomBar(
    this.str1,
    this.str2,
    this.str3,
    this.str4,
    this.str5,
    this.address,
    this.cityId,
    this.click,
  );
  //BottomBar(this.str1, this.str2, this.str3, this.str4, address);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String userId;
  //List<bool> click = [true, false, false, false, false];
  bool isClick = false, isLoading = false;
  @override
  void initState() {
    SetUserId().getUserIdLocal().then((value) {
      userId = value;
      //print("UserId from local: $userId");
    });
    print("Click : ${widget.click}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("Click 0: ${widget.click[0]}");
                  if (widget.click[0] != true && isClick != true) {
                    // setState(() {
                    //   isClick = true;
                    // });
                    // setState(() {
                    //   widget.click[0] = true;
                    //   click[1] = false;
                    //   click[2] = false;
                    //   click[3] = false;
                    //   click[4] = false;
                    // });
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomeScreen(),
                    //   ),
                    // );
                  }
                },
                child: SvgPicture.asset(widget.str1),
              ),
              GestureDetector(
                onTap: () {
                  print("Click 1: ${widget.click[1]}");

                  if (widget.click[1] != true && isClick != true) {
                    // setState(() {
                    //   isClick = true;
                    // });
                    // setState(() {
                    //   click[0] = false;
                    //   click[1] = true;
                    //   click[2] = false;
                    //   click[3] = false;
                    //   click[4] = false;
                    // });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomeScreen(),
                    //   ),
                    // );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlogScreen(widget.address, widget.cityId, userId),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset(widget.str2),
              ),
              GestureDetector(
                onTap: () {
                  print("Click 2: ${widget.click[2]}");

                  if (widget.click[2] != true && isClick != true) {
                    setState(() {
                      isClick = true;
                      isLoading = true;
                    });
                    getTrackOrderHomeData(userId).then((value1) {
                      setState(() {
                        isClick = false;
                      });
                      if (value1.status == 1) {
                        if (value1.kitchenDetail[0].lat != null ||
                            value1.kitchenDetail[0].long != null) {
                          CurrentLocation().getCurrentLatLong().then((value) {
                            // userLocation = LocationData.fromMap({
                            //   "latitude": value.latitude,
                            //   "longitude": value.longitude,
                            // });
                            setState(() {
                              isLoading = false;
                            });
                            try {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrackOrderHomeScreen(
                                    userId,
                                    //ord[position].kitchenId,

                                    LocationData.fromMap({
                                      "latitude": value.latitude,
                                      "longitude": value.longitude,
                                    }),
                                    LocationData.fromMap(
                                      {
                                        "latitude": double.parse(
                                            value1.kitchenDetail[0].lat),
                                        "longitude": double.parse(
                                            value1.kitchenDetail[0].long),
                                        // "latitude": var1.latitude,
                                        // "longitude": var1.longitude,
                                      },
                                    ),
                                  ),
                                ),
                              );
                            } catch (e) {
                              print(e);
                            }
                          });
                        } else {
                          print("Not Okay");
                        }
                      } else if (value1.status == 0) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => HomeScreen(),
                        //   ),
                        // );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackOrderScreenHome(
                                widget.address, userId, widget.cityId),
                          ),
                        );
                      }
                    });
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomeScreen(),
                  //   ),
                  // );
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TrackOrderScreenHome(
                  //         widget.address, userId, widget.cityId),
                  //   ),
                  // );
                },
                child: SvgPicture.asset(widget.str5),
              ),
              GestureDetector(
                onTap: () {
                  print("Click 3: ${widget.click[3]}");

                  if (widget.click[3] != true && isClick != true) {
                    // setState(() {
                    //   isClick = true;
                    // });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomeScreen(),
                    //   ),
                    // );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewKitchenScreen(
                            widget.address, userId, widget.cityId),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset(widget.str3),
              ),
              GestureDetector(
                onTap: () {
                  print("Click 4: ${widget.click[4]}");

                  if (widget.click[4] != true && isClick != true) {
                    // setState(() {
                    //   isClick = true;
                    // });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomeScreen(),
                    //   ),
                    // );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAccountScreen(
                            userId, widget.address, widget.cityId),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset(widget.str4),
              ),
            ],
          ),
        ),
        isLoading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.transparent,
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
              ),
      ],
    );
  }
}
