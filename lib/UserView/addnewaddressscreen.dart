import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/add_new_address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/UserView/manageaddressscreen.dart';

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

class AddNewAddressScreen extends StatefulWidget {
  final String userId;
  AddNewAddressScreen(this.userId);
  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  String address,
      landMark = "",
      addtype = "Home",
      latitude = "",
      longitude = "",
      location = "";
  List<String> addressType = ["Home", "Work"];
  Address first;
  List<String> addressList = [" ", " ", " "];
  bool _isLoading = false;

  TextEditingController _contoller1 = new TextEditingController();
  TextEditingController _contoller2 = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  final List<_PositionItem> _positionItems = <_PositionItem>[];

  @override
  void initState() {
    // PushNotification().initialize();
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
                    height: 80.0,
                    top: 24,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      color: Colors.orange[900],
                      child: Center(
                        child: Text(
                          "No Internet",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.grey[700]),
          centerTitle: true,
          title: Text(
            'Add New Address',
            style: TextStyle(
              color: Colors.grey[800],
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
              Container(
                margin: EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        Center(
                          child: SvgPicture.asset('assets/svg/Group 2009.svg'),
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
                                // print("$value");
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
                                final coordinates = new Coordinates(
                                    double.parse(latitude),
                                    double.parse(longitude));
                                var addresses = await Geocoder.local
                                    .findAddressesFromCoordinates(coordinates);
                                setState(() {
                                  first = addresses.first;
                                  addressList = first.addressLine.split(",");
                                  _contoller1.text = first.featureName +
                                      ", " +
                                      first.thoroughfare +
                                      ", " +
                                      first.subAdminArea;
                                  _contoller2.text = first.adminArea +
                                      ' - ' +
                                      first.postalCode;
                                  address = _contoller1.text;
                                  location = _contoller2.text;
                                  _isLoading = false;
                                  // pincode = first.postalCode;
                                  // city = first.subAdminArea;
                                });
                                // print(
                                //     "${first.featureName} : ${first.subAdminArea}");
                              });
                            } catch (e) {
                              print(e);
                              setState(() {
                                _isLoading = false;
                              });
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
                                      'Current Location',
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.red)),
                          ),
                          child: TextFormField(
                            controller: _contoller1,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Address*';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'HOUSE/FLAT/BLOCK NO.',
                              labelText: 'Address 1*',
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.red)),
                          ),
                          child: TextFormField(
                            controller: _contoller2,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Address*';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Street/Locality',
                              labelText: 'Address 2*',
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                location = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.red)),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'LANDMARK',
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                landMark = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.red)),
                          ),
                          child: Center(
                            child: new DropdownButton(
                              //isDense: true,
                              isExpanded: true,
                              elevation: 0,
                              hint: (addtype == null)
                                  ? Text("Home")
                                  : Text("$addtype"),
                              style: (addtype == null)
                                  ? TextStyle(
                                      color: Colors.grey[500],
                                    )
                                  : TextStyle(
                                      color: Colors.grey[900],
                                    ),
                              value: addtype,
                              items: addressType.map((dis) {
                                return DropdownMenuItem(
                                  child: new Text(dis),
                                  value: dis,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  addtype = value;
                                });
                                print("$addtype");
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              if (latitude == "" || longitude == "") {
                                Fluttertoast.showToast(
                                  msg: "Please get current location",
                                  fontSize: 20,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              } else {
                                setState(() {
                                  _isLoading = true;
                                });
                                getAddAddress(widget.userId, location, address,
                                        landMark, addtype, latitude, longitude)
                                    .then((value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (value.status == 1) {
                                    //Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: "${value.message}",
                                      fontSize: 20,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      toastLength: Toast.LENGTH_LONG,
                                    );
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ManageAddressScreen(widget.userId),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Something went wrong",
                                      fontSize: 20,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      toastLength: Toast.LENGTH_LONG,
                                    );
                                  }
                                });
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[800],
                              child: Container(
                                height:
                                    50, //MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Center(
                                  child: Text(
                                    'ADD ADDRESS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              _isLoading ? loader(context) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
