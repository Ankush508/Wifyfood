import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:provider/src/provider.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/get_current_location.dart';
import 'package:wifyfood/Helper/restartwidget.dart';
import 'package:wifyfood/UserHandlers/track_order_home.dart';
import 'package:wifyfood/UserView/blogscreen.dart';
import 'package:wifyfood/UserView/homescreen.dart';
import 'package:wifyfood/UserView/myaccountscreen.dart';
import 'package:wifyfood/UserView/newkitchen.dart';
import 'package:wifyfood/UserView/otpverificationscreen.dart';
import 'package:wifyfood/UserView/trackorderscreenhome.dart';

class UserDashboardScreen extends StatefulWidget {
  final String userId;
  // const UserDashboardScreen({Key key}) : super(key: key);
  UserDashboardScreen(this.userId);

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String home, home_, blog, blog_, track, track_, newKit, newKit_, acc, acc_;
  int trackorderstatus;
  double lat, long, kitLat, kitLong;

  @override
  void initState() {
    // SetUserId().getUserIdLocal().then((value) {
    //   userId = value;
    //   print("User Id from Dashboard: $userId");
    // });

    print("User Id from Dashboard: ${widget.userId}");

    getTrackOrderHomeData(widget.userId).then((value) {
      trackorderstatus = value.status;
      if (value.kitchenDetail[0].lat != null ||
          value.kitchenDetail[0].long != null) {
        CurrentLocation().getCurrentLatLong().then((value1) {
          setState(() {
            lat = value1.latitude;
            long = value1.longitude;
            kitLat = double.parse(value.kitchenDetail[0].lat);
            kitLong = double.parse(value.kitchenDetail[0].long);
          });
        });
      }
    });
    home = 'assets/svg/Icon feather-home.svg';
    home_ = 'assets/svg/Icon feather-home-1.svg';
    blog = 'assets/svg/blog.svg';
    blog_ = 'assets/svg/blog (1).svg';
    track = 'assets/svg/Tracking.svg';
    track_ = 'assets/svg/Tracking_red.svg';
    newKit = 'assets/svg/register kitchen.svg';
    newKit_ = 'assets/svg/register kitchen (1).svg';
    acc = 'assets/svg/Icon feather-user.svg';
    acc_ = 'assets/svg/Icon feather-user-1.svg';

    // _tabController = TabController(length: _kTabPages.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CartCount>();
    final List<Widget> _children = [
      // Home Screen
      HomeScreen(widget.userId),
      // Blog Screen
      BlogScreen(c.address, c.cityId, widget.userId),
      // Track Order Home Screen
      (trackorderstatus == 1)
          ? TrackOrderHomeScreen(
              widget.userId,
              //ord[position].kitchenId,

              LocationData.fromMap({
                "latitude": lat,
                "longitude": long,
              }),
              LocationData.fromMap(
                {
                  "latitude": kitLat,
                  "longitude": kitLong,
                  // "latitude": var1.latitude,
                  // "longitude": var1.longitude,
                },
              ),
            )
          : TrackOrderScreenHome(c.address, widget.userId, c.cityId),
      // New Kitchen Screen
      NewKitchenScreen(c.address, widget.userId, c.cityId),
      // My Account Screen
      MyAccountScreen(widget.userId, c.address, c.cityId),
    ];

    /*var _kTabPages = <Widget>[
      // Home Screen
      HomeScreen(),
      // Blog Screen
      BlogScreen(c.address, c.cityId, userId),
      // Track Order Home Screen
      (trackorderstatus == 1)
          ? TrackOrderHomeScreen(
              userId,
              //ord[position].kitchenId,

              LocationData.fromMap({
                "latitude": lat,
                "longitude": long,
              }),
              LocationData.fromMap(
                {
                  "latitude": kitLat,
                  "longitude": kitLong,
                  // "latitude": var1.latitude,
                  // "longitude": var1.longitude,
                },
              ),
            )
          : TrackOrderScreenHome(c.address, userId, c.cityId),
      // New Kitchen Screen
      NewKitchenScreen(c.address, userId, c.cityId),
      // My Account Screen
      MyAccountScreen(userId, c.address, c.cityId),
    ];

    var _kTab = <Tab>[
      Tab(
        icon: SvgPicture.asset(home),
      ),
      Tab(
        icon: SvgPicture.asset(blog),
      ),
      Tab(
        icon: SvgPicture.asset(track),
      ),
      Tab(
        icon: SvgPicture.asset(newKit),
      ),
      Tab(
        icon: SvgPicture.asset(acc),
      ),
    ];*/

    return Scaffold(
      /*body: TabBarView(
        controller: _tabController,
        children: _kTabPages,
      ),*/
      body: IndexedStack(
        index: c.currentIndex,
        children: _children,
      ),
      // body: _children[c.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: c.currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(home),
            activeIcon: SvgPicture.asset(home_),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(blog),
            activeIcon: SvgPicture.asset(blog_),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(track),
            activeIcon: SvgPicture.asset(track_),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(newKit),
            activeIcon: SvgPicture.asset(newKit_),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: SvgPicture.asset(acc),
            activeIcon: SvgPicture.asset(acc_),
            label: "",
          ),
        ],
      ),
      /*bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          tabs: _kTab,
          controller: _tabController,
        ),
      ),*/
    );
  }

  void onTabTapped(int index) {
    // setState(() {
    //   context.watch<CartCount>().currentIndex = index;
    // });
    print("Bottom Tab Index: $index");
    Provider.of<CartCount>(context, listen: false).getIndex(index);
  }
}
