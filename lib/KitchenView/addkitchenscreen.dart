import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/register_kitchen.dart';
import 'package:wifyfood/UserHandlers/city_list.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/main.dart';
import 'package:flutter_offline/flutter_offline.dart';
// import 'package:connectivity/connectivity.dart';

enum _PositionItemType {
  // permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

// ignore: must_be_immutable
class AddKitchenScreen extends StatefulWidget {
  final String ownerName,
      dob,
      kitchenName,
      cuisine,
      email,
      mobile,
      password,
      logo;
  final List<City> cities;
  AddKitchenScreen(this.ownerName, this.dob, this.kitchenName, this.cuisine,
      this.email, this.mobile, this.password, this.logo, this.cities);
  @override
  _AddKitchenScreenState createState() => _AddKitchenScreenState();
}

class _AddKitchenScreenState extends State<AddKitchenScreen> {
  String latitude = "",
      longitude = "",
      location,
      city,
      pincode,
      deviceId,
      description,
      state;
  bool field1 = false;
  bool _isLoading = false;

  final _formKey = new GlobalKey<FormState>();

  Address first;
  List<String> address = [" ", " ", " "];

  TextEditingController _contoller = new TextEditingController();

  final List<_PositionItem> _positionItems = <_PositionItem>[];
  var subscription;

  @override
  void initState() {
    SetToken().getTokenIdLocal().then((value) {
      setState(() {
        deviceId = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final connected = connectivity != ConnectivityResult.none;
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            connected
                ? Container()
                : Positioned(
                    height: 25.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                      child: Center(
                        child: Text(
                          // "${connected ? 'ONLINE' : 'OFFLINE'}",
                          connected ? "ONLINE" : "OFFLINE",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
            connected
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black12,
                  )
          ],
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey[700]),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                    padding: EdgeInsets.only(
                        top: 30, left: 30, right: 30, bottom: 30),
                    //height: 812,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                              'assets/svg/Vector Smart Object-6.svg'),
                        ),
                        SizedBox(height: 50),
                        //Spacer(),
                        Text(
                          Languages.of(context).addKitName,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
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
                                initialValue: widget.kitchenName,
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  border: InputBorder.none,
                                  hintText: 'Ex. Hungary Food Restaurant',
                                  hintStyle: TextStyle(
                                      //fontSize: 18,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await Geolocator.getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.high,
                              ).then((value) async {
                                //print("$value");
                                // _positionItems.add(
                                //   _PositionItem(
                                //     _PositionItemType.position,
                                //     value.toString(),
                                //   ),
                                // );
                                setState(() {
                                  latitude = value.latitude.toString();
                                  longitude = value.longitude.toString();
                                });
                                print("Latitude: $latitude");
                                print("Longitude: $longitude");
                                final coordinates = new Coordinates(
                                    double.parse(latitude),
                                    double.parse(longitude));
                                var addresses = await Geocoder.local
                                    .findAddressesFromCoordinates(coordinates);
                                setState(() {
                                  first = addresses.first;
                                  address = first.addressLine.split(",");
                                  _contoller.text = first.addressLine;
                                  _isLoading = false;

                                  setState(() {
                                    if (_contoller.text.isEmpty) {
                                      field1 = true;
                                    } else
                                      field1 = false;
                                  });
                                  location = _contoller.text;
                                  pincode = first.postalCode;
                                  city = first.subAdminArea;
                                  state = first.adminArea;
                                  // _isLoading = true;
                                  // for (int i = 0;
                                  //     i < widget.cities.length;
                                  //     i++) {
                                  //   if (city == widget.cities[i].cityName) {
                                  //     cityId = widget.cities[i].cityId;
                                  //   }
                                  // }
                                  // if (cityId == null || cityId == "") {
                                  //   for (int i = 0;
                                  //       i < widget.cities.length;
                                  //       i++) {
                                  //     if (first.adminArea ==
                                  //         widget.cities[i].cityName) {
                                  //       cityId = widget.cities[i].cityId;
                                  //     }
                                  //   }
                                  // } else if (cityId == null || cityId == "") {
                                  //   cityId = first.adminArea;
                                  // }
                                });
                                print(
                                    "${first.featureName} : ${first.thoroughfare}: ${first.subAdminArea}: ${first.adminArea}: ${first.postalCode}");
                              });
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "$e",
                                fontSize: 20,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                            // dismissProgressDialog();
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            //color: Colors.white,
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width, //120,
                              height: 50,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Languages.of(context).kitLoc,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.location_searching,
                                      color: Colors.grey[700],
                                    )
                                    //SizedBox(width: 5),
                                    //Image.asset('assets/discount.png'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          Languages.of(context).address,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
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
                                //initialValue: first.addressLine,
                                controller: _contoller,
                                validator: (value) {
                                  if (field1 == true) {
                                    return "Enter Kitchen's Location*";
                                  }
                                  return null;
                                },
                                //readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  border: InputBorder.none,
                                  hintText: Languages.of(context).streetCity,
                                  hintStyle: TextStyle(
                                      //fontSize: 18,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.bold),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    location = _contoller.text;
                                    pincode = first.postalCode;
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

                        SizedBox(height: 15),
                        Text(
                          Languages.of(context).aboutYou,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(30),
                          //color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Container(
                              child: TextFormField(
                                scrollPhysics: AlwaysScrollableScrollPhysics(),
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return "Required*";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Languages.of(context).writeAbYou,
                                  hintStyle: TextStyle(
                                      //fontSize: 18,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.bold),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    description = value;
                                  });
                                },
                                maxLines: 100,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                if (location == null || location == "") {
                                  field1 = true;
                                }
                              });
                              if (latitude == "" || longitude == "") {
                                Flushbar(
                                  //flushbarStyle: FlushbarStyle.GROUNDED,
                                  icon: Icon(Icons.error),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  title: "Error",
                                  message: "Get Location",
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.red,
                                ).show(context);
                              } else if (description == null ||
                                  description == "") {
                                Flushbar(
                                  //flushbarStyle: FlushbarStyle.GROUNDED,
                                  icon: Icon(Icons.error),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  title: "Error",
                                  message: "Write something about you",
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.red,
                                ).show(context);
                              } else {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  // showProgressDialog(
                                  //     context: context,
                                  //     loadingText: "Saving...");
                                  try {
                                    getRegisterKitchen(
                                            widget.ownerName,
                                            widget.dob,
                                            widget.kitchenName,
                                            widget.cuisine,
                                            widget.email,
                                            location,
                                            latitude,
                                            longitude,
                                            pincode,
                                            description,
                                            deviceId,
                                            widget.mobile,
                                            widget.password,
                                            widget.logo,
                                            city,
                                            state)
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      // dismissProgressDialog();
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                        msg: "Kitchen Registered",
                                        fontSize: 20,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                        toastLength: Toast.LENGTH_LONG,
                                      );
                                    });
                                  } catch (e) {
                                    // dismissProgressDialog();
                                    Fluttertoast.showToast(
                                      msg: "$e",
                                      fontSize: 20,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      toastLength: Toast.LENGTH_LONG,
                                    );
                                  }
                                } catch (e) {
                                  Fluttertoast.showToast(
                                    msg: "$e",
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(28, 149, 71, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                Languages.of(context).save,
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
              ),
              _isLoading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black12,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
