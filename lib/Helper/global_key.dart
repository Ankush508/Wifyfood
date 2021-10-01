import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/UserView/cartscreen.dart';

/// Global variables
/// * [GlobalKey<NavigatorState>]
class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  // static final GlobalKey<BuildContext> navContext = GlobalKey<BuildContext>();
  // static final c = navState.currentState.context.watch<CartCount>();
  static final c = navState.currentContext.watch<CartCount>();
}
