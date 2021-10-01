import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserView/reviewscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

double rating = 1;

enum _PositionItemType {
  // permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class TrackOrderScreen extends StatefulWidget {
  final String userId;
  TrackOrderScreen(this.userId);
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  String latitude = "", longitude = "", _placeDistance;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.248727, 72.7031885),
    zoom: 12,
  );

  final List<_PositionItem> _positionItems = <_PositionItem>[];
  Position startCoordinates;
  Position destinationCoordinates;
  Position kitchenCoordinates;

  Set<Marker> markers = {};
  Set<LatLng> poly = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
/*
  Future getLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == true) {
      // LocationPermission permission = await Geolocator.checkPermission();

      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
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
          startCoordinates = value;
          // destinationCoordinates = Position(latitude: ,longitude: )
        });
        print("Latitude: $latitude");
        print("Longitude: $longitude");
        print("Start Coordinates: $startCoordinates");
        print("Destination Coordinates: $destinationCoordinates");
      });
    }
  }

  BitmapDescriptor pinLocationIcon;

// Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // User location marker
      Marker userMarker = Marker(
        markerId: MarkerId('$startCoordinates'),
        position: LatLng(
          startCoordinates.latitude,
          startCoordinates.longitude,
        ),
        infoWindow: InfoWindow(
          title: 'User',
          // snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        // icon: BitmapDescriptor.fromAssetImage(configuration, assetName)
      );
      // Kitchen location marker
      Marker kitchenMarker = Marker(
        markerId: MarkerId('$destinationCoordinates'),
        position: LatLng(
          destinationCoordinates.latitude,
          destinationCoordinates.longitude,
        ),
        infoWindow: InfoWindow(
          title: 'Kitchen',
          // snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      // Delivery location marker
      Marker deliveryMarker = Marker(
        markerId: MarkerId('$destinationCoordinates'),
        position: LatLng(
          destinationCoordinates.latitude,
          destinationCoordinates.longitude,
        ),
        infoWindow: InfoWindow(
          title: 'Delivery Boy',
          // snippet: _destinationAddress,
        ),
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        // icon: BitmapDescriptor.fromAsset("assets/food-delivery.png"),
        // icon: BitmapDescriptor.fromAssetImage(configuration, assetName)
        icon: pinLocationIcon,
      );

      //markers.add(userMarker);
      markers.add(deliveryMarker);

      print('START COORDINATES: $startCoordinates');
      print('DESTINATION COORDINATES: $destinationCoordinates');

      // Position _northeastCoordinates;
      // Position _southwestCoordinates;

      // // Calculating to check that
      // // southwest coordinate <= northeast coordinate
      // if (startCoordinates.latitude <= destinationCoordinates.latitude) {
      //   _southwestCoordinates = startCoordinates;
      //   _northeastCoordinates = destinationCoordinates;
      // } else {
      //   _southwestCoordinates = destinationCoordinates;
      //   _northeastCoordinates = startCoordinates;
      // }
      // mapController.animateCamera(
      //   CameraUpdate.newLatLngBounds(
      //     LatLngBounds(
      //       northeast: LatLng(
      //         _northeastCoordinates.latitude,
      //         _northeastCoordinates.longitude,
      //       ),
      //       southwest: LatLng(
      //         _southwestCoordinates.latitude,
      //         _southwestCoordinates.longitude,
      //       ),
      //     ),
      //     100.0,
      //   ),
      // );

      await _createPolylines(startCoordinates, destinationCoordinates);

      // double totalDistance = 0.0;

      // // Calculating the total distance by adding the distance
      // // between small segments
      // for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      //   totalDistance += _coordinateDistance(
      //     polylineCoordinates[i].latitude,
      //     polylineCoordinates[i].longitude,
      //     polylineCoordinates[i + 1].latitude,
      //     polylineCoordinates[i + 1].longitude,
      //   );
      // }
      // setState(() {
      //   _placeDistance = totalDistance.toStringAsFixed(2);
      //   print('DISTANCE: $_placeDistance km');
      // });

      return true;
    } catch (e) {}
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(Position start, Position destination) async {
    // print("Slat: ${start.latitude}");
    // print("Slong: ${start.longitude}");
    // print("Dlat: ${destination.latitude}");
    // print("Dlong: ${destination.longitude}");
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAHNRYrkIjYo0t-cKN1bJwIS0RxsKroLlc", // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    //print("Result: ${result.errorMessage}");

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  StreamSubscription<Position> _positionStreamSubscription;

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream =
          Geolocator.getPositionStream(intervalDuration: Duration(seconds: 5));
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription.cancel();
        _positionStreamSubscription = null;
      }).listen((position) {
        setState(
          () => _positionItems.add(
            _PositionItem(_PositionItemType.position, position.toString()),
          ),
        );
        print("Position: $position");
        // setDelLatLongData(position.latitude.toString(),
        //     position.longitude.toString(), widget.userId);
        getTrackOrderData(widget.userId).then((value) {
          setState(() {
            destinationCoordinates = Position(
                latitude: double.parse(value.deliveryDetail.lat),
                longitude: double.parse(value.deliveryDetail.long));
            _calculateDistance();
          });
        });
      });
      _positionStreamSubscription.pause();
    }

    setState(() {
      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }
*/
  @override
  void initState() {
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration(
    //           devicePixelRatio: 2.5,
    //           size: Size(2, 2),
    //         ),
    //         'assets/food-delivery.png')
    //     .then((onValue) {
    //   pinLocationIcon = onValue;
    // });
    // getLocation().then((value) {
    //   _toggleListening();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: AssetImage('assets/delivery_map.png'),
                        //   fit: BoxFit.fill,
                        // ),
                        ),
                    child: GoogleMap(
                      markers:
                          markers != null ? Set<Marker>.from(markers) : null,
                      polylines: Set<Polyline>.of(polylines.values),
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: _kGooglePlex,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                        // _controller.complete(controller);
                        // GoogleMapController mapController = controller;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 1,
                          child: Slider(
                            activeColor: Colors.green[800],
                            value: rating,
                            onChanged: (double value) {
                              setState(() {
                                rating = value;
                                print(rating);
                              });
                            },
                            divisions: 3,
                            min: 1,
                            max: 4,
                          ),
                        ),
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
                                Text(
                                  '12:10, Sep 2, 2020',
                                  style: TextStyle(
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Column(
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
                                  '12:10, Sep 3, 2020',
                                  style: TextStyle(
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Column(
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
                                  '12:10, Sep 4, 2020',
                                  style: TextStyle(
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Column(
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
                                  '12:10, Sep 5, 2020',
                                  style: TextStyle(
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewScreen(widget.userId, ""),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red[700],
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          height: 50, //MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'assets/svg/Shape 1 copy 4.svg'),
                                  SvgPicture.asset(
                                      'assets/svg/Shape 1 copy 4.svg'),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
