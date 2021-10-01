import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/collapsing_navigation_drawer_user.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/cart.dart';
import 'package:wifyfood/UserHandlers/city_list.dart';
import 'package:wifyfood/UserHandlers/dashboard.dart';
import 'package:wifyfood/UserHandlers/user_latlong.dart';
import 'package:wifyfood/UserHandlers/user_profile.dart';
import 'package:wifyfood/UserView/changelocationscreen.dart';
import 'package:wifyfood/UserView/searchkitchenscreen.dart';
import 'package:wifyfood/UserView/cartscreen.dart';
import 'package:wifyfood/UserView/otpverificationscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserView/viewrestaurantscreen.dart';
import 'package:wifyfood/UserView/viewallkitchenscreen.dart';

enum _PositionItemType {
  // permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class HomeScreen extends StatefulWidget {
  final String uid;
  HomeScreen(this.uid);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String string1, string2, string3, string4, string5, city;
  String latitude = "", longitude = "";
  bool loadingAddress = true,
      topLoading = true,
      promotedLoading = true,
      specialLoading = true;
  Address first;
  List<String> add = [];
  List<City> cities = [];
  String getAdd;
  List addGet = [];
  final List<_PositionItem> _positionItems = <_PositionItem>[];

  Future getLocation() async {
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
        Provider.of<CartCount>(context, listen: false)
            .updateLatLong(latitude, longitude);
        print("Latitude: $latitude");
        print("Longitude: $longitude");
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

        getAdd = first.addressLine;
        // addGet = getAdd.split(",");
        Provider.of<CartCount>(context, listen: false)
            .getAddressData(add, getAdd);
        city = first.subAdminArea;
        for (int i = 0; i < cities.length; i++) {
          if (city == cities[i].cityName) {
            context.watch<CartCount>().cityId = cities[i].cityId;
          }
        }
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

  Widget topPickLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: (bytes.length < 10)
              ? DecorationImage(
                  image: AssetImage("assets/no image.jpg"),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: MemoryImage(bytes),
                  fit: BoxFit.cover,
                ),
        ),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.35,
      ),
    );
  }

  Widget topPickListView(
      context, List<TopPick> topPickListData, String userId) {
    return (topPickListData.length == 0)
        ? Center(
            child: Container(
              child: Text(
                Languages.of(context).service,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.35 + 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topPickListData.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewRestaurantScreen(
                          userId,
                          topPickListData[position].id,
                          topPickListData[position].kitchenName,
                          topPickListData[position].location,
                          topPickListData[position].rating,
                          topPickListData[position].cuisine,
                          topPickListData[position].fav,
                          topPickListData[position].logo,
                          context.watch<CartCount>().address,
                          topPickListData[position].bannerImage,
                          context.watch<CartCount>().lat,
                          context.watch<CartCount>().long,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        topPickLogo(topPickListData[position].logo),
                        // Material(
                        //   elevation: 10,
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       image: DecorationImage(
                        //         image:
                        //             AssetImage('assets/Indain Veg Thali.png'),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     width: MediaQuery.of(context).size.width * 0.5,
                        //     height: MediaQuery.of(context).size.height * 0.35,
                        //   ),
                        // ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            '${topPickListData[position].kitchenName}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            '${topPickListData[position].location}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          height: 20,
                          //color: Colors.black12,
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (topPickListData[position].rating == null)
                                  ? Container()
                                  : SvgPicture.asset(
                                      'assets/svg/Shape -1.svg',
                                      width: 14,
                                    ),
                              SizedBox(width: 5),
                              (topPickListData[position].rating == null)
                                  ? Container()
                                  : Text(
                                      '${topPickListData[position].rating.substring(0, 3)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              (topPickListData[position].rating == null)
                                  ? Container()
                                  : SizedBox(width: 10),
                              // Image.asset('assets/Vector Smart Object-12.png'),
                              SvgPicture.asset('assets/svg/clock.svg'),
                              SizedBox(width: 5),
                              Text(
                                '40 min',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget promotedKitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: (bytes.length < 10)
              ? DecorationImage(
                  image: AssetImage("assets/no image.jpg"),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: MemoryImage(bytes),
                  fit: BoxFit.cover,
                ),
        ),
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }

  Widget promotedListView(
      context, List<Promoted> promotedListData, String userId) {
    return (promotedListData.length == 0)
        ? Center(
            child: Container(
              child: Text(
                Languages.of(context).service,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: promotedListData.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewRestaurantScreen(
                          userId,
                          promotedListData[position].id,
                          promotedListData[position].kitchenName,
                          promotedListData[position].location,
                          promotedListData[position].rating,
                          promotedListData[position].cuisine,
                          promotedListData[position].fav,
                          promotedListData[position].logo,
                          context.watch<CartCount>().address,
                          promotedListData[position].bannerImage,
                          context.watch<CartCount>().lat,
                          context.watch<CartCount>().long,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        promotedKitchenLogo(promotedListData[position].logo),
                        // Material(
                        //   elevation: 10,
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       image: DecorationImage(
                        //         image:
                        //             AssetImage('assets/Indain Veg Thali.png'),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     width: MediaQuery.of(context).size.width * 0.2,
                        //     height: MediaQuery.of(context).size.width * 0.2,
                        //   ),
                        // ),
                        SizedBox(height: 5),
                        Text(
                          '${promotedListData[position].kitchenName}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget specialOfferLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: (bytes.length < 10)
              ? DecorationImage(
                  image: AssetImage("assets/no image.jpg"),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: MemoryImage(bytes),
                  fit: BoxFit.cover,
                ),
        ),
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }

  Widget specialOfferListView(
      context, List<Special> specialOfferListData, String userId) {
    return (specialOfferListData.length == 0)
        ? Center(
            child: Container(
              child: Text(
                Languages.of(context).service,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialOfferListData.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewRestaurantScreen(
                          userId,
                          specialOfferListData[position].id,
                          specialOfferListData[position].kitchenName,
                          specialOfferListData[position].location,
                          specialOfferListData[position].rating,
                          specialOfferListData[position].cuisine,
                          specialOfferListData[position].fav,
                          specialOfferListData[position].logo,
                          context.watch<CartCount>().address,
                          specialOfferListData[position].bannerImage,
                          context.watch<CartCount>().lat,
                          context.watch<CartCount>().long,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        specialOfferLogo(specialOfferListData[position].logo),
                        // Material(
                        //   elevation: 10,
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       image: DecorationImage(
                        //         image:
                        //             AssetImage('assets/Indain Veg Thali.png'),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     width: MediaQuery.of(context).size.width * 0.2,
                        //     height: MediaQuery.of(context).size.width * 0.2,
                        //   ),
                        // ),
                        SizedBox(height: 5),
                        Text(
                          '50% Discount',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${specialOfferListData[position].kitchenName}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  String firstName = "";
  String lastName = "";
  String profilePic = "";
  String cartCount = "0";

  // void updateCartCount() {
  //   getCart(uid).then((value) {
  //     print("Cart Count: ${value.cart.length}");
  //     setState(() {
  //       cartCount = value.cart.length.toString();
  //     });
  //   });
  // }
  // void updateCartCount(String _count) {
  //   setState(() => cartCount = _count);
  // }

  @override
  void initState() {
    getCityListData().then((value) {
      cities = value;
    });
    getLocation().then((value) {
      SetUserId().getUserIdLocal().then((value) {
        // uid = value;
        setState(() {});
        getProfileData(widget.uid).then((value) {
          setState(() {
            firstName = value.response.firstName;
            lastName = value.response.lastName;
            profilePic = value.response.image;
          });
        });
        getCart(widget.uid).then((value) {
          print("Cart Count: ${value.cart.length}");
          // updateCartCount(value.cart.length.toString());
          Provider.of<CartCount>(context, listen: false)
              .upCartCount(value.cart.length.toString());
        });
        // CartCount().updateCartCount(uid);
        if (latitude != null || latitude != "") {
          getUserLatLongData(context.watch<CartCount>().lat,
              context.watch<CartCount>().long, widget.uid);
        }
        //getDashboardUserList(uid, latitude, longitude);
      });
      setState(() {
        loadingAddress = false;
      });
    });

    string1 = 'assets/svg/Icon feather-home-1.svg';
    string2 = 'assets/svg/blog.svg';
    string3 = 'assets/svg/register kitchen.svg';
    string4 = 'assets/svg/Icon feather-user.svg';
    string5 = 'assets/svg/Tracking.svg';
    // PushNotification().initialize();

    super.initState();
  }

  @override
  void dispose() {
    Geolocator.getCurrentPosition();
    getLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CartCount>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Image.asset(
              'assets/Icon feather-menu.png',
              scale: 1.2,
            ),
          ),
        ),
        // alignment: Alignment(-1.2, 0),
        title: loadingAddress
            ? Container(
                child: Text("Loading..."),
              )
            : InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeLocationScreen(
                              latitude, longitude, widget.uid)));
                },
                child: Container(
                  // color: Colors.black12,
                  child: Transform.translate(
                    offset: Offset(-25, 0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          //color: Colors.black26,
                          padding: const EdgeInsets.only(left: 0),
                          //width: 20,
                          child: Image.asset(
                            "assets/placeholder_2.png",
                            scale: 20,
                          ),
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${c.address[0]}',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                // (address[1] == " ")
                                //     ? " "
                                //     :
                                "${c.add}",
                                style: TextStyle(fontSize: 10),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        actions: [
          Container(
            //color: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(widget.uid),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                        'assets/svg/Icon feather-shopping-cart.svg'),
                    UpCartCount(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: CollapsingNavigationDrawerUser(
          widget.uid, c.address, profilePic, firstName, lastName, c.cityId),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: Container(
              //margin: EdgeInsets.only(top: 80),
              child: SingleChildScrollView(
                physics: ScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  //margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          Languages.of(context).discover,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          Languages.of(context).experience,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          //color: Colors.white,
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 20),
                            width: MediaQuery.of(context).size.width, //120,
                            height: 50,
                            child: Center(
                              child: TextFormField(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchKitchenScreen(
                                          widget.uid,
                                          latitude,
                                          longitude,
                                          c.address,
                                          c.cityId,
                                          profilePic,
                                          firstName,
                                          lastName,
                                          getAdd),
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey[700],
                                  ),
                                  border: InputBorder.none,
                                  hintText: Languages.of(context).searchOnHome,
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.75 - 20,
                              child: Text(
                                Languages.of(context).topPick,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.black12,
                              width:
                                  MediaQuery.of(context).size.width * 0.25 - 20,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewAllKitchenScreen(
                                              widget.uid, c.address),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    Languages.of(context).viewAll,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      FutureBuilder(
                        future: getTopPickData(widget.uid),
                        builder: (context, snapshot) {
                          return (snapshot.data != null)
                              ? topPickListView(
                                  context, snapshot.data, widget.uid)
                              : Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          Languages.of(context).promoted,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: FutureBuilder(
                          future: getPromotedKitchenData(widget.uid),
                          builder: (context, snapshot) {
                            return (snapshot.data != null)
                                ? promotedListView(
                                    context, snapshot.data, widget.uid)
                                : Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          Languages.of(context).special,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: FutureBuilder(
                          future: getSpecialOfferData(widget.uid),
                          builder: (context, snapshot) {
                            return (snapshot.data != null)
                                ? specialOfferListView(
                                    context, snapshot.data, widget.uid)
                                : Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // bottomNavigationBar: BottomBar(string1, string2, string3, string4,
      //     string5, address, cityId, [true, false, false, false, false]),
    );
  }
}
