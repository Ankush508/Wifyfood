import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/check_mobile_number.dart';
import 'package:wifyfood/UserView/otpverificationscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/main.dart';

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

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String mobNumber, latitude = "", longitude = "", place, devId;
  bool field1 = false;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  final _formKey = new GlobalKey<FormState>();

  Future getLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == true) {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((value) {
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
      final coordinates =
          new Coordinates(double.parse(latitude), double.parse(longitude));
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
    } else {
      Geolocator.requestPermission();
    }
  }

  @override
  void initState() {
    getLocation();
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
          Languages.of(context).registration,
          style: TextStyle(),
        ),
        actions: [],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
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
                  flex: 1,
                  child: Container(
                    child: BackgroundCircle(),
                  ),
                ),
                Expanded(
                  flex: 1,
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
                      child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                            'assets/svg/Vector Smart Object-6.svg'),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 2.0, color: Colors.white24),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 0),
                                          child: Center(
                                            child: Text(
                                              Languages.of(context).code,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: TextFormField(
                                              inputFormatters: [
                                                new LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                              cursorColor: Colors.white,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                              validator: (value) {
                                                if (field1 == true) {
                                                  return Languages.of(context)
                                                      .mobileError1;
                                                } else if (value.length == 0) {
                                                  return null;
                                                } else if (value.length != 10) {
                                                  return Languages.of(context)
                                                      .mobileError2;
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 0),
                                                border: InputBorder.none,
                                                prefixStyle: TextStyle(
                                                    color: Colors.white),
                                                hintText: Languages.of(context)
                                                    .mobileNo,
                                                hintStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                                errorStyle: TextStyle(
                                                    color: Colors.yellow),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  mobNumber = value;
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
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  if (mobNumber == null || mobNumber == "") {
                                    field1 = true;
                                  }
                                });
                                if (mobNumber == null || mobNumber == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Enter Mobile Number",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (latitude == null || latitude == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Try Again !!",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else {
                                  //print(mobNumber);
                                  getMobileData(
                                          mobNumber, devId, latitude, longitude)
                                      .then((value) {
                                    if (value.resCode == 1) {
                                      print('Otp: ${value.otp}');
                                      // Fluttertoast.showToast(
                                      //   msg: "Otp: ${value.otp}",
                                      //   fontSize: 20,
                                      //   textColor: Colors.white,
                                      //   backgroundColor: Colors.blue,
                                      //   toastLength: Toast.LENGTH_LONG,
                                      //   gravity: ToastGravity.CENTER,
                                      // );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OtpVerificationScreen(mobNumber),
                                        ),
                                      );
                                    } else if (value.resCode == 0) {
                                      print('Res: ${value.response}');
                                      Fluttertoast.showToast(
                                        msg: Languages.of(context)
                                            .mobileExistMsg,
                                        fontSize: 20,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    }
                                  }).timeout(Duration(seconds: 10),
                                          onTimeout: () {
                                    Fluttertoast.showToast(
                                      msg: "Request TimeOut !!",
                                      fontSize: 20,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  });
                                }
                              }
                            },
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: Center(
                                  child: Text(
                                    Languages.of(context).confirm,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
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
