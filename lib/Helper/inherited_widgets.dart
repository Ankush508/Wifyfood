import 'package:flutter/material.dart';
import 'package:wifyfood/UserHandlers/cart.dart';

// class CartCount extends InheritedWidget {
//   CartCount({Key key, this.child}) : super(key: key, child: child);

//   final Widget child;
//   final String count = "0";

//   static CartCount of(BuildContext context) {
//     final result = context.dependOnInheritedWidgetOfExactType<CartCount>();
//     assert(result != null, "${CartCount().count}");
//     return result;
//   }

//   @override
//   bool updateShouldNotify(CartCount old) => count != old.count;
// }

class InheritedCartCount extends ChangeNotifier {
  String cartCount = "0";

  // bool get darkTheme => _darkTheme;
  void updCartCount(String _count) {
    cartCount = _count;
  }
}
