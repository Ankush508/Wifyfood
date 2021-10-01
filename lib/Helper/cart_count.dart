import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCount extends ChangeNotifier {
  String cartCount = "0";

  void upCartCount(String _count) {
    cartCount = _count;
    notifyListeners();
  }

  /////////////////////////////////////////////

  bool isBell = false;

  void updateBell(bool change) {
    isBell = change;
    notifyListeners();
  }

  /////////////////////////////////////////////

  String navigateData = "";

  void getNavigateData(String data) {
    navigateData = data;
    notifyListeners();
  }

  /////////////////////////////////////////////

  List<String> address = ["", "", ""];
  String add;

  void getAddressData(List<String> data1, String data2) {
    address = data1;
    add = data2;
    notifyListeners();
  }

  /////////////////////////////////////////////

  String cityId;

  void getCityId(String data) {
    cityId = data;
    notifyListeners();
  }

  /////////////////////////////////////////////

  int currentIndex = 0;

  void getIndex(int data) {
    currentIndex = data;
    notifyListeners();
  }

  /////////////////////////////////////////////

  String uid;

  void updateUserId(String data) {
    uid = data;
    notifyListeners();
  }

  /////////////////////////////////////////////

  String lat = "", long = "";
  void updateLatLong(String data1, String data2) {
    lat = data1;
    long = data2;
    notifyListeners();
  }
}

class UpCartCount extends StatefulWidget {
  @override
  _UpCartCountState createState() => _UpCartCountState();
}

class _UpCartCountState extends State<UpCartCount> {
  @override
  Widget build(BuildContext context) {
    final c = context.watch<CartCount>();
    return Text(
      "  ${c.cartCount}",
      // "  $cartCount",
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class KitchenBell extends StatefulWidget {
  @override
  _KitchenBellState createState() => _KitchenBellState();
}

class _KitchenBellState extends State<KitchenBell> {
  @override
  Widget build(BuildContext context) {
    final c = context.watch<CartCount>();
    return c.isBell
        ? Icon(Icons.notifications_active_outlined,
            color: Colors.deepOrange[800])
        : Icon(Icons.notifications_none_outlined,
            color: Colors.deepOrange[800]);
  }
}

// class ChangeBellIcon extends ChangeNotifier {
//   bool isBell = false;

//   // bool get darkTheme => _darkTheme;
//   void updateBell(bool change) {
//     isBell = change;
//     notifyListeners();
//   }
// }
