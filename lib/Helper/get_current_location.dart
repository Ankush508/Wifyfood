import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum _PositionItemType {
  // permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class CurrentLocation {
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  String latitude = "", longitude = "";

  Future<LatLng> getCurrentLatLong() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LatLng location;
    print("Location Service Enabled: $isLocationServiceEnabled");
    if (isLocationServiceEnabled == true) {
      try {
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
          // setState(() {

          // });
          latitude = value.latitude.toString();
          longitude = value.longitude.toString();
          location = LatLng(value.latitude, value.longitude);
          print("Latitude: $latitude");
          print("Longitude: $longitude");
        });
      } catch (e) {
        //int count = 100;
        print(e);
        //Geolocator.getCurrentPosition();
        print("Service: $isLocationServiceEnabled");
        // Fluttertoast.showToast(
        //   msg: "GPS is Required",
        //   fontSize: 20,
        //   textColor: Colors.white,
        //   backgroundColor: Colors.blue,
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.CENTER,
        // );

        //Geolocator.openAppSettings();
      }
    }
    return location;
  }
}
