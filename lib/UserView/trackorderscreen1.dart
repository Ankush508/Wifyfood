import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/track_order.dart';
import 'package:wifyfood/UserView/reviewscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:percent_indicator/percent_indicator.dart';

double rating = 1;
const double CAMERA_ZOOM_INITIAL = 15;
const double CAMERA_ZOOM_LATER = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
// const LatLng SOURCE_LOCATION = LatLng(23.2486963, 72.7032196);
// const LatLng DEST_LOCATION = LatLng(23.0346716, 72.5636915);
const LatLng var1 = LatLng(23.242417, 72.676069);
const LatLng var2 = LatLng(23.199406, 72.651581);
const LatLng var3 = LatLng(23.174845, 72.637370);
const LatLng var4 = LatLng(23.131396, 72.630080);
const LatLng var5 = LatLng(23.098321, 72.588721);

class TrackOrderScreen extends StatefulWidget {
  final String userId, kitchenId, orderId;
  final LocationData userData, kitData;
  TrackOrderScreen(
      this.userId, this.kitchenId, this.orderId, this.userData, this.kitData);
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen>
    with TickerProviderStateMixin {
  GifController controller;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Timer timer;
  List<int> stat = [];
  String dateTime1, dateTime2, dateTime3, dateTime4;
  bool _dateTime1 = false,
      _dateTime2 = false,
      _dateTime3 = false,
      _dateTime4 = false;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  BitmapDescriptor deliveryIcon;
  LocationData deliveryLocation;
  LocationData userLocation;
  LocationData kitchenLocation;
  Location location;

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(23.248727, 72.7031885),
  //   zoom: 12,
  // );
  bool initialLocation = false;
  @override
  void initState() {
    // stat.add(1);
    // PushNotification().initialize();
    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();
    controller = GifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.repeat(min: 0, max: 15, period: Duration(milliseconds: 1200));
    });

    setInitialLocation();
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    // location.onLocationChanged.listen((LocationData cLoc) {
    //   // cLoc contains the lat and long of the
    //   // current user's position in real time,
    //   // so we're holding on to it
    //   userLocation = cLoc;
    //   updatePinOnMap();
    // });
    timer = new Timer.periodic(Duration(seconds: 2), (timer) async {
      print("Timer Tick: ${timer.tick}");
      getTrackOrderMenuListData(widget.orderId).then((value) {
        print("Menu Length : ${value.length}");
        print("Stat Length : ${stat.length}");
        if (value.length == 1 && stat.length == 0) {
          // stat.add(1);
          setState(() {
            dateTime1 = value[0].dateTime;
            _dateTime1 = true;
          });
        } else if (value.length == 2 && stat.length == 0) {
          stat.add(1);
          setState(() {
            dateTime1 = value[0].dateTime;
            dateTime2 = value[1].dateTime;
            _dateTime1 = true;
            _dateTime2 = true;
          });
        } else if (value.length == 2 && stat.length == 1) {
          // stat.add(1);
          setState(() {
            dateTime1 = value[0].dateTime;
            dateTime2 = value[1].dateTime;
            _dateTime1 = true;
            _dateTime2 = true;
          });
        } else if (value.length == 3 && stat.length == 0) {
          stat.add(1);
          stat.add(1);
          setState(() {
            dateTime1 = value[0].dateTime;
            dateTime2 = value[1].dateTime;
            dateTime3 = value[2].dateTime;
            _dateTime1 = true;
            _dateTime2 = true;
            _dateTime3 = true;
          });
        } else if (value.length == 3 && stat.length == 1) {
          stat.add(1);
          setState(() {
            dateTime3 = value[2].dateTime;
            _dateTime1 = true;
            _dateTime2 = true;
            _dateTime3 = true;
          });
        } else if (value.length == 4 && stat.length == 2) {
          stat.add(1);
          setState(() {
            dateTime4 = value[3].dateTime;
            _dateTime1 = true;
            _dateTime2 = true;
            _dateTime3 = true;
            _dateTime4 = true;
          });
        }
      });

      getTrackOrderDelListData(widget.orderId).then((value) {
        print("Delivery Latitude : ${value[0].lat}");
        print("Delivery Longitude : ${value[0].long}");
        if (value[0].lat != "" && value[0].long != "") {
          print("Updating");
          updatePinOnMap(value[0].lat, value[0].long);
        }
      });

      // updatePinOnMap();
    });
    /*Timer.periodic(Duration(seconds: 5), (timer) {
      print("Timer Tick: ${timer.tick}");
      if (timer.tick == 0) {
        userLocation = LocationData.fromMap({
          "latitude": SOURCE_LOCATION.latitude,
          "longitude": SOURCE_LOCATION.longitude,
        });
        updatePinOnMap();
      } else if (timer.tick == 5) {
        userLocation = LocationData.fromMap({
          "latitude": var1.latitude,
          "longitude": var1.longitude,
        });
        updatePinOnMap();
      } else if (timer.tick == 10) {
        userLocation = LocationData.fromMap({
          "latitude": var2.latitude,
          "longitude": var2.longitude,
        });
        updatePinOnMap();
      } else if (timer.tick == 15) {
        userLocation = LocationData.fromMap({
          "latitude": var3.latitude,
          "longitude": var3.longitude,
        });
        updatePinOnMap();
      } else if (timer.tick == 20) {
        userLocation = LocationData.fromMap({
          "latitude": var4.latitude,
          "longitude": var4.longitude,
        });
        updatePinOnMap();
      } else if (timer.tick == 25) {
        userLocation = LocationData.fromMap({
          "latitude": var5.latitude,
          "longitude": var5.longitude,
        });
        updatePinOnMap();
      } else if (timer.tick == 30) {
        timer.cancel();
      }
    });*/
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    // setInitialLocation();
    super.initState();
  }

  void setSourceAndDestinationIcons() async {
    deliveryIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/placeholder.png");

    sourceIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

    destinationIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }

  void setInitialLocation() async {
    userLocation = LocationData.fromMap({
      "latitude": widget.userData.latitude,
      "longitude": widget.userData.longitude,
    });

    kitchenLocation = LocationData.fromMap({
      "latitude": widget.kitData.latitude,
      "longitude": widget.kitData.longitude
    });
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData userLocation object
    var pinPosition = LatLng(userLocation.latitude, userLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(kitchenLocation.latitude, kitchenLocation.longitude);
    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAHNRYrkIjYo0t-cKN1bJwIS0RxsKroLlc",
      PointLatLng(kitchenLocation.latitude, kitchenLocation.longitude),
      PointLatLng(userLocation.latitude, userLocation.longitude),
      // userLocation.latitude,
      // userLocation.longitude,
      // kitchenLocation.latitude,
      // kitchenLocation.longitude,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            width: 4, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap(String lat, String long) async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM_LATER,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(double.parse(lat), double.parse(long)),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var delPosition = LatLng(double.parse(lat), double.parse(long));

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == "deliveryPin");
      _markers.add(Marker(
          markerId: MarkerId("deliveryPin"),
          position: delPosition, // updated position
          icon: deliveryIcon));
    });
  }

  @override
  void dispose() {
    showPinsOnMap();
    //updatePinOnMap();
    setInitialLocation();
    setPolylines();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM_INITIAL,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(widget.userData.latitude, widget.userData.longitude));
    if (deliveryLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(deliveryLocation.latitude, deliveryLocation.longitude),
          zoom: CAMERA_ZOOM_LATER,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          Container(
            //margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/delivery_map.png'),
                      //   fit: BoxFit.fill,
                      // ),
                      ),
                  child: GoogleMap(
                    // markers:
                    //     markers != null ? Set<Marker>.from(markers) : null,
                    // polylines: Set<Polyline>.of(polylines.values),
                    markers: _markers,
                    polylines: _polylines,
                    // zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: initialCameraPosition,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      showPinsOnMap();

                      // _controller.complete(controller);
                      // GoogleMapController mapController = controller;
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  // color: Colors.black12,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: LinearPercentIndicator(
                            animation: true,
                            lineHeight: 20.0,
                            percent: (stat.length == 0)
                                ? 0.1
                                : (stat.length == 1)
                                    ? 0.33
                                    : (stat.length == 2)
                                        ? 0.66
                                        : 1.0,
                            // center: Text("80.0%"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context).orderRes,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  //color: Colors.grey[700],
                                ),
                              ),
                              _dateTime1
                                  ? Text(
                                      '$dateTime1',
                                      style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey[700]),
                                    )
                                  : Container(
                                      height: 14,
                                    ),
                            ],
                          ),
                          _dateTime2
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Languages.of(context).foodPrep,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        //color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '$dateTime2',
                                      style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Languages.of(context).foodPrep,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Container(
                                      height: 14,
                                    ),
                                  ],
                                ),
                          _dateTime3
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Languages.of(context).outDel,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        //color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '$dateTime3',
                                      style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Languages.of(context).outDel,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Container(
                                      height: 14,
                                    ),
                                  ],
                                ),
                          _dateTime4
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Languages.of(context).delivered,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        //color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '$dateTime4',
                                      style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Languages.of(context).delivered,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Container(
                                      height: 14,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                //Spacer(),
                _dateTime4
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReviewScreen(widget.userId, widget.kitchenId),
                            ),
                          );
                        },
                        child: Container(
                          // padding: const EdgeInsets.all(10.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red[700],
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: 50, //MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/Shape 1 copy 2.svg'),
                                      SvgPicture.asset(
                                          'assets/svg/Shape 1 copy 2.svg'),
                                      SvgPicture.asset(
                                          'assets/svg/Shape 1 copy 2.svg'),
                                      SvgPicture.asset(
                                          'assets/svg/Shape 1 copy 2.svg'),
                                      SvgPicture.asset(
                                          'assets/svg/Shape 1 copy 2.svg'),
                                    ],
                                  ),
                                  Text(
                                    Languages.of(context).writeRev,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),

                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.black26,
                    // height: MediaQuery.of(context).size.height * 0.4,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GifImage(
                        image: AssetImage("assets/gif/delivery-boy.gif"),
                        controller: controller,
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
