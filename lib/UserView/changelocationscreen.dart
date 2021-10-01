import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:provider/src/provider.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Helper/restartwidget.dart';
import 'package:wifyfood/UserHandlers/user_latlong.dart';
import 'package:google_place/google_place.dart';

class ChangeLocationScreen extends StatefulWidget {
  final lat, long, userId;
  // const ChangeLocationScrenn({ Key? key }) : super(key: key);
  ChangeLocationScreen(this.lat, this.long, this.userId);

  @override
  _ChangeLocationScreenState createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  TextEditingController controller = new TextEditingController();
  GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  bool isLoading = false;

  /*onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    kitchenList.forEach((kitchen) {
      if (kitchen.kitchenName.contains(text)) searchResult.add(kitchen);
    });

    setState(() {});
  }*/

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  @override
  void initState() {
    // String apiKey = DotEnv().env['API_KEY'];
    String apiKey = "AIzaSyAHNRYrkIjYo0t-cKN1bJwIS0RxsKroLlc";
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    //qcolor: Colors.white,
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 20),
                      width: MediaQuery.of(context).size.width, //120,
                      height: 50,
                      child: Center(
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          //autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[700],
                            ),
                            border: InputBorder.none,
                            hintText: "Search your city",
                            hintStyle: TextStyle(
                              //fontSize: 18,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // onChanged: onSearchTextChanged,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {
                              if (predictions.length > 0 && mounted ||
                                  controller.text.isEmpty) {
                                setState(() {
                                  predictions = [];
                                });
                              }
                            }
                          },
                          // onTap: () {
                          //   FocusScope.of(context).nextFocus();
                          // },
                          //   onTap: () {
                          //   controller.clear();
                          //   onSearchTextChanged('');
                          // },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: (predictions.length == 0)
                      ? CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                            size: 50,
                          ),
                        )
                      : ListView.builder(
                          itemCount: predictions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Icon(
                                  Icons.pin_drop,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                predictions[index].description,
                                maxLines: 3,
                              ),
                              onTap: () {
                                FocusScope.of(context).nextFocus();
                                setState(() {
                                  isLoading = true;
                                });
                                debugPrint(predictions[index].placeId);
                                googlePlace.details
                                    .get(predictions[index].placeId)
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print(
                                      "${value.result.geometry.location.lat}");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeLocationMapScreen(
                                              value
                                                  .result.geometry.location.lat
                                                  .toString(),
                                              value.result.geometry.location.lng
                                                  .toString(),
                                              widget.userId),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.black12,
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

/////////////////////////// Google Map Screen //////////////////////////////

enum _PositionItemType {
  // permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class ChangeLocationMapScreen extends StatefulWidget {
  final lat, long, userId;
  // const ChangeLocationScreen({Key key}) : super(key: key);
  ChangeLocationMapScreen(this.lat, this.long, this.userId);

  @override
  _ChangeLocationMapScreenState createState() =>
      _ChangeLocationMapScreenState();
}

class _ChangeLocationMapScreenState extends State<ChangeLocationMapScreen> {
  Address first;
  List<String> add = [];
  String getAdd;
  String latitude, longitude;
  double newLat, newLong;
  bool loadingAddress = true, clickConfirmLoc = false;
  final List<_PositionItem> _positionItems = <_PositionItem>[];

  Future getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == true) {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(minutes: 1),
      ).then((value) {
        //print("$value");
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
        setState(() {
          newLat = value.latitude;
          newLong = value.longitude;
        });
        // Provider.of<CartCount>(context, listen: false)
        //     .updateLatLong(latitude, longitude);
        // print("Latitude: $latitude");
        // print("Longitude: $longitude");
      });

      final coordinates =
          new Coordinates(double.parse(latitude), double.parse(longitude));
      // final coordinates = new Coordinates(28.614733897301257, 77.4252769572928);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      first = addresses.first;
      //address = first.addressLine.split(",");
      setState(() {
        add.add(first.subAdminArea);
        add.add(first.adminArea);
        add.add(first.postalCode);
        // CartCount().getAddressData(add);
        Provider.of<CartCount>(context, listen: false)
            .getAddressData(add, getAdd);
        getAdd = first.addressLine;
        // addGet = getAdd.split(",");
        // city = first.subAdminArea;
        // for (int i = 0; i < cities.length; i++) {
        //   if (city == cities[i].cityName) {
        //     context.watch<CartCount>().cityId = cities[i].cityId;
        //   }
        // }
      });
      // print("Address : $addGet");
      print("Address : ${first.addressLine}");
      print(
          "${first.subAdminArea} :${first.featureName} :${first.locality} : ${first.subLocality} :${first.subThoroughfare} : ${first.thoroughfare}  : ${first.adminArea} : ${first.postalCode}");
    } else {
      Geolocator.requestPermission();
      Geolocator.getCurrentPosition();
      // Fluttertoast.showToast(
      //   msg: "Turn on your GPS",
      //   fontSize: 20,
      //   textColor: Colors.white,
      //   backgroundColor: Colors.blue,
      //   toastLength: Toast.LENGTH_LONG,
      // );
    }
  }

  Future getLocation() async {
    final coordinates =
        new Coordinates(double.parse(widget.lat), double.parse(widget.long));

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;

    setState(() {
      add.add(first.subAdminArea);
      add.add(first.adminArea);
      add.add(first.postalCode);

      Provider.of<CartCount>(context, listen: false)
          .getAddressData(add, getAdd);
      getAdd = first.addressLine;
    });
  }

  @override
  void initState() {
    print("Initial Latitude: ${widget.lat}");
    print("Initial Longitude: ${widget.long}");
    getLocation().then((value) {
      // Provider.of<CartCount>(context, listen: false)
      //       .updateLatLong(latitude, longitude);
      setState(() {
        loadingAddress = false;
        newLat = double.parse(widget.lat);
        newLong = double.parse(widget.long);
      });
    });
    super.initState();
  }

  LatLng _initialcameraposition;
  // GoogleMapController _controller;
  Completer<GoogleMapController> _controller = Completer();
  // Location _location = Location();

  /*void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    /*_location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });*/
    // getLocation().then((value) {
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //         target: LatLng(value.latitude, value.longitude), zoom: 15),
    //   );
    // });
  }*/

  void onCameraMove(CameraPosition position) {
    print(
        "Latitude: ${position.target.latitude}; Longitude: ${position.target.longitude}");
    setState(() {
      newLat = position.target.latitude;
      newLong = position.target.longitude;
    });
  }

  Future<void> _onCameraIdle() async {
    /*_location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
      _initialcameraposition =
          LatLng(double.parse(widget.lat), double.parse(widget.long));
      print("onCamaraMove: ${l.latitude},${l.longitude}");
    });*/
    print("Camera Stopped");
    /*getLocation().then((value) {
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(value.latitude, value.longitude), zoom: 15),
      );
    });*/
    final GoogleMapController controller = await _controller.future;
    controller.getScreenCoordinate(LatLng(newLat, newLong)).then((sc) {
      print("Screen Coordinate: ${sc.x} : ${sc.y}");
      setState(() {
        loadingAddress = true;
      });
      controller
          .getLatLng(ScreenCoordinate(x: sc.x, y: sc.y))
          .then((value) async {
        print("New LatLong: ${value.latitude} : ${value.longitude}");
        print("New LatLong: $newLat : $newLong");
        final coordinates = new Coordinates(value.latitude, value.longitude);
        // final coordinates = new Coordinates(28.614733897301257, 77.4252769572928);
        var newAddress =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        print("${newAddress.first.addressLine}");
        setState(() {
          add[0] = newAddress.first.subAdminArea;
          getAdd = newAddress.first.addressLine;
          loadingAddress = false;
        });
      });
    });
    /*controller
        .getLatLng(ScreenCoordinate(
            x: MediaQuery.of(context).size.width ~/ 2,
            y: ((MediaQuery.of(context).size.height - 24) * 0.7) ~/ 2))
        .then((value) async {
      print("New Lat: ${value.latitude}");
      print("New Long: ${value.longitude}");
      final coordinates = new Coordinates(value.latitude, value.longitude);
      // final coordinates = new Coordinates(28.614733897301257, 77.4252769572928);
      var newAddress =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      print("${newAddress.first.addressLine}");
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CartCount>();
    _initialcameraposition =
        LatLng(double.parse(widget.lat), double.parse(widget.long));
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            BackgroundScreen(),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height - 24) * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        GoogleMap(
                          onCameraMove: onCameraMove,
                          // liteModeEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: _initialcameraposition, zoom: 15),
                          mapType: MapType.normal,
                          zoomControlsEnabled: false,
                          // onMapCreated: _onMapCreated,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            // showPinsOnMap();

                            // _controller.complete(controller);
                            // GoogleMapController mapController = controller;
                          },
                          onCameraIdle: _onCameraIdle,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,

                          padding: EdgeInsets.symmetric(
                            // top: 40,
                            // right: 20,
                            vertical: 40,
                            horizontal: 20,
                          ),
                          // padding: EdgeInsets.only(
                          //   top: MediaQuery.of(context).size.height - 120,
                          //   right: 20,
                          // ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () async {
                              final GoogleMapController controller =
                                  await _controller.future;
                              controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: LatLng(double.parse(widget.lat),
                                          double.parse(widget.long)),
                                      zoom: 15),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(30),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.my_location,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Transform.translate(
                            offset: Offset(0, -20),
                            child: Container(
                              // margin: const EdgeInsets.all(30),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: (MediaQuery.of(context).size.height - 24) * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          loadingAddress
                              ? Container(
                                  child: Text(
                                    "Loading...",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${add[0]}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "$getAdd",
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                clickConfirmLoc = true;
                              });
                              Provider.of<CartCount>(context, listen: false)
                                  .updateLatLong(
                                      newLat.toString(), newLong.toString());
                              Provider.of<CartCount>(context, listen: false)
                                  .getAddressData(add, getAdd);
                              getUserLatLongData(newLat.toString(),
                                      newLong.toString(), widget.userId)
                                  .then((value) {
                                print("User LatLong Updated............");
                                setState(() {
                                  clickConfirmLoc = false;
                                });
                                RestartWidget.restartApp(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width * 0.7,
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
                                child: clickConfirmLoc
                                    ? CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        "Confirm Location",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
