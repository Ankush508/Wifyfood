import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/add_item.dart';
import 'package:wifyfood/UserHandlers/cart.dart';
import 'package:wifyfood/UserHandlers/coupon_list.dart';
import 'package:wifyfood/UserHandlers/favorite_kitchen.dart';
import 'package:wifyfood/UserHandlers/menu_list.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserView/cartscreen.dart';
import 'package:wifyfood/UserView/homescreen.dart';

String noImageUrl =
    "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg";

final GlobalKey<HomeScreenState> homeGlobalKey =
    new GlobalKey<HomeScreenState>();

class ViewRestaurantScreen extends StatefulWidget {
  final String userId,
      kitchenId,
      kitchenName,
      kitchenLocation,
      kitchenRating,
      cuisine,
      fav,
      bnImage,
      lat,
      long;
  final String logo;
  final List<String> address;
  ViewRestaurantScreen(
      this.userId,
      this.kitchenId,
      this.kitchenName,
      this.kitchenLocation,
      this.kitchenRating,
      this.cuisine,
      this.fav,
      this.logo,
      this.address,
      this.bnImage,
      this.lat,
      this.long);
  @override
  _ViewRestaurantScreenState createState() => _ViewRestaurantScreenState();
}

class _ViewRestaurantScreenState extends State<ViewRestaurantScreen> {
  String string1, string2, string3, string4;
  //List<String> itemTotal = [];
  List<String> itemTotal = [], imgList = [], address = [];
  String favorite;
  List<bool> selectQuantityHalf = [];
  List<bool> selectQuantityFull = [];
  List<bool> selectMenuItem = [];
  bool isfav = false;
  // bool isfav = (widget.fav == "0" || null) ? false : true;
  String selectQuantityAmount;
  List<String> quantityType = [];
  List<MenuList> menuListData;
  String category = "1";
  String itemId;

  bool click1 = true;
  bool click2 = false;
  bool click3 = false;

  // Widget menu() {
  //   switch (category) {
  //     case "1":
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Recommended',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuCategoryListData(widget.kitchenId, category),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //       break;
  //     case "2":
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Soups',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuCategoryListData(widget.kitchenId, category),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //       break;
  //     case "3":
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Quick Bites',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuCategoryListData(widget.kitchenId, category),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //       break;
  //     case "4":
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Starters',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuCategoryListData(widget.kitchenId, category),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //       break;
  //     case "5":
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Main Course',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuCategoryListData(widget.kitchenId, category),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //       break;
  //     case "6":
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Family Binge Combos',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuCategoryListData(widget.kitchenId, category),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //       break;
  //     case "7":
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Beverage Combos',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuCategoryListData(widget.kitchenId, category),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //       break;
  //     default:
  //       return ListView(
  //         shrinkWrap: true,
  //         physics: ScrollPhysics(),
  //         children: [
  //           SizedBox(height: 20),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: Text(
  //               'Recommended',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           FutureBuilder(
  //             future: getMenuListData(widget.userId),
  //             builder: (context, snapshot) {
  //               return snapshot.data != null
  //                   ? menuList(snapshot.data, widget.userId)
  //                   : Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //             },
  //           ),
  //           SizedBox(height: 40),
  //         ],
  //       );
  //   }
  // }

  var itemPic;

  Widget menuItemLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  var itemPicL;

  Widget menuItemLogoL(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget menuItemLogoBig(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

// Regular Menu List
  Widget menuList(List<MenuList> menuListItemData, String kitchenId) {
    final c = context.watch<CartCount>();
    //print("Length: ${menuListItemData.length}");
    return (menuListItemData.length == 0)
        ? Container(
            height: 200,
            child: Center(
              child: Text(
                Languages.of(context).emptyList,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          )
        : ListView.builder(
            //physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: menuListItemData.length + 1,
            itemBuilder: (context, position) {
              // print("Menu Item length: ${menuListItemData.length}");
              return (position == menuListItemData.length)
                  ? Container(
                      height: 100,
                      // color: Colors.black12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/fssai.png",
                            scale: 20,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Fssai Lic: 13621999000016",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        // if (selectMenuItem[position] == true) {
                        //   setState(() {
                        //     selectMenuItem[position] = false;
                        //   });
                        // } else if (selectMenuItem[position] == false) {
                        //   setState(() {
                        //     selectMenuItem[position] = true;
                        //   });
                        // }
                        showDialog(
                          //barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, StateSetter setState) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  //insetAnimationCurve: Curves.bounceIn,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        menuItemLogoBig(
                                            menuListItemData[position].photo),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '${menuListItemData[position].dishName}',
                                            style: TextStyle(
                                                fontSize: 26,
                                                //color: Colors.black87,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '₹' +
                                                '${menuListItemData[position].fullPrice}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '${menuListItemData[position].description}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                //color: Colors.black87,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //   height: selectMenuItem[position] ? 100 : 60,
                            //   width: selectMenuItem[position] ? 100 : 60,
                            //   // width: 60,
                            //   // height: 60,
                            //   child: Image.asset(
                            //     'assets/Rounded Rectangle 2.png',
                            //     scale: 1,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            // selectMenuItem[position]
                            //     ? menuItemLogoL(menuListItemData[position].photo)
                            //     :
                            menuItemLogo(menuListItemData[position].photo),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                // color: Colors.black12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${menuListItemData[position].dishName}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          //color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      '₹${menuListItemData[position].fullPrice}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '${menuListItemData[position].description}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w300),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' MORE',
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                showGeneralDialog(
                                  barrierLabel: "Label",
                                  barrierDismissible: true,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  transitionDuration:
                                      Duration(milliseconds: 400),
                                  context: context,
                                  pageBuilder: (context, anim1, anim2) {
                                    return StatefulBuilder(builder:
                                        (context, StateSetter setState) {
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 30,
                                              left: 20,
                                              right: 20,
                                              bottom: 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Languages.of(context).quantity,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                              SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    setState(() {
                                                      quantityType[position] =
                                                          "2";
                                                      selectQuantityHalf[
                                                          position] = false;
                                                      selectQuantityFull[
                                                          position] = true;
                                                      itemTotal[position] =
                                                          menuListData[position]
                                                              .fullPrice;
                                                    });
                                                  });
                                                },
                                                child: Material(
                                                  color: Colors.white,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                            ),
                                                            selectQuantityFull[
                                                                    position]
                                                                ? Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                        SizedBox(width: 15),
                                                        (widget.cuisine ==
                                                                "Mixed")
                                                            ? Image.asset(
                                                                "assets/blue.png",
                                                                scale: 15,
                                                              )
                                                            : (widget.cuisine ==
                                                                    "Non-veg")
                                                                ? Image.asset(
                                                                    "assets/red.png",
                                                                    scale: 15,
                                                                  )
                                                                : Image.asset(
                                                                    "assets/green.png",
                                                                    scale: 15,
                                                                  ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          Languages.of(context)
                                                                  .full +
                                                              " ₹${menuListItemData[position].fullPrice}",
                                                          //'Item Total ₹$itemTotal',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              (menuListItemData[position]
                                                          .halfPrice ==
                                                      "0")
                                                  ? SizedBox(height: 0)
                                                  : SizedBox(height: 20),
                                              (menuListItemData[position]
                                                          .halfPrice ==
                                                      "0")
                                                  ? Container()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          quantityType[
                                                              position] = "1";
                                                          selectQuantityHalf[
                                                              position] = true;
                                                          selectQuantityFull[
                                                              position] = false;
                                                          itemTotal[position] =
                                                              menuListData[
                                                                      position]
                                                                  .halfPrice;
                                                        });
                                                      },
                                                      child: Material(
                                                        color: Colors.white,
                                                        child: Container(
                                                          //color: Colors.black12,
                                                          child: Row(
                                                            children: [
                                                              Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .red,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  ),
                                                                  selectQuantityHalf[
                                                                          position]
                                                                      ? Container(
                                                                          height:
                                                                              12,
                                                                          width:
                                                                              12,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.red,
                                                                            borderRadius:
                                                                                BorderRadius.circular(50),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              12,
                                                                          width:
                                                                              12,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(50),
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  width: 15),
                                                              Image.asset(
                                                                'assets/veg.png',
                                                                scale: 15,
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                Languages.of(
                                                                            context)
                                                                        .half +
                                                                    ' ₹${menuListItemData[position].halfPrice}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              Spacer(),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Container(
                                                  height: 80,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Material(
                                                        child: Text(
                                                          (quantityType[
                                                                      position] ==
                                                                  "1")
                                                              ? 'Half'
                                                              : 'Full',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          if (selectQuantityHalf[
                                                                  position] ==
                                                              true) {
                                                            setState(() {
                                                              selectQuantityAmount =
                                                                  menuListData[
                                                                          position]
                                                                      .halfPrice;
                                                            });
                                                          } else if (selectQuantityFull[
                                                                  position] ==
                                                              true) {
                                                            setState(() {
                                                              selectQuantityAmount =
                                                                  menuListData[
                                                                          position]
                                                                      .fullPrice;
                                                            });
                                                          }
                                                          print(
                                                              "${quantityType[position]}");
                                                          if (quantityType[
                                                                      position] ==
                                                                  "1" ||
                                                              quantityType[
                                                                      position] ==
                                                                  "2") {
                                                            getAddItemData(
                                                                    widget
                                                                        .userId,
                                                                    menuListData[
                                                                            position]
                                                                        .id,
                                                                    selectQuantityAmount,
                                                                    quantityType[
                                                                        position],
                                                                    widget
                                                                        .kitchenId)
                                                                .then((value) {
                                                              getCart(widget
                                                                      .userId)
                                                                  .then(
                                                                      (value) {
                                                                print(
                                                                    "Cart Count: ${value.cart.length}");
                                                                c.upCartCount(value
                                                                    .cart.length
                                                                    .toString());
                                                                updateCartCount(
                                                                    value.cart
                                                                        .length
                                                                        .toString());
                                                              });
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Item added in cart",
                                                                fontSize: 20,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                              );
                                                            });
                                                          } else {
                                                            Fluttertoast
                                                                .showToast(
                                                              msg: "Try Again",
                                                              fontSize: 20,
                                                              textColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                            );
                                                          }

                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //     builder: (context) => BillDetailsScreen(),
                                                          //   ),
                                                          // );
                                                        },
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.green[800],
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20),
                                                            height:
                                                                50, //MediaQuery.of(context).size.height,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  selectQuantityFull[
                                                                          position]
                                                                      ? Languages.of(context)
                                                                              .total +
                                                                          ' ₹${menuListItemData[position].fullPrice}'
                                                                      : Languages.of(context)
                                                                              .total +
                                                                          ' ₹${menuListItemData[position].halfPrice}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  Languages.of(
                                                                          context)
                                                                      .addItem,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            //color: Colors.transparent,
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  transitionBuilder:
                                      (context, anim1, anim2, child) {
                                    return SlideTransition(
                                      position: Tween(
                                              begin: Offset(0, 1),
                                              end: Offset(0, 0))
                                          .animate(anim1),
                                      child: child,
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20),
                                    //color: Colors.white,
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                    ),
                                  ),
                                  Text(
                                    Languages.of(context).add + ' +',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
          );
  }

  // Special Menu List
  Widget specialMenuList(
      List<SpecialMenuList> specialMenuListItemData, String kitchenId) {
    final c = context.watch<CartCount>();
    print("Length: ${specialMenuListItemData.length}");
    return (specialMenuListItemData.length == 0)
        ? Container(
            height: 200,
            child: Center(
              child: Text(
                Languages.of(context).emptyList,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          )
        : ListView.builder(
            //physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: specialMenuListItemData.length + 1,
            itemBuilder: (context, position) {
              // print("Menu Item length: ${menuListItemData.length}");
              return (position == specialMenuListItemData.length)
                  ? Container(
                      height: 100,
                      // color: Colors.black12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/fssai.png",
                            scale: 20,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Fssai Lic: 13621999000016",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        // if (selectMenuItem[position] == true) {
                        //   setState(() {
                        //     selectMenuItem[position] = false;
                        //   });
                        // } else if (selectMenuItem[position] == false) {
                        //   setState(() {
                        //     selectMenuItem[position] = true;
                        //   });
                        // }
                        showDialog(
                          //barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, StateSetter setState) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  //insetAnimationCurve: Curves.bounceIn,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        menuItemLogoBig(
                                            specialMenuListItemData[position]
                                                .photo),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '${specialMenuListItemData[position].dishName}',
                                            style: TextStyle(
                                                fontSize: 26,
                                                //color: Colors.black87,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '₹' +
                                                '${specialMenuListItemData[position].fullPrice}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '${specialMenuListItemData[position].description}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                //color: Colors.black87,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //   height: selectMenuItem[position] ? 100 : 60,
                            //   width: selectMenuItem[position] ? 100 : 60,
                            //   // width: 60,
                            //   // height: 60,
                            //   child: Image.asset(
                            //     'assets/Rounded Rectangle 2.png',
                            //     scale: 1,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            // selectMenuItem[position]
                            //     ? menuItemLogoL(menuListItemData[position].photo)
                            //     :
                            menuItemLogo(
                                specialMenuListItemData[position].photo),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                // color: Colors.black12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${specialMenuListItemData[position].dishName}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          //color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      '₹${specialMenuListItemData[position].fullPrice}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '${specialMenuListItemData[position].description}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w300),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' MORE',
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                showGeneralDialog(
                                  barrierLabel: "Label",
                                  barrierDismissible: true,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  transitionDuration:
                                      Duration(milliseconds: 400),
                                  context: context,
                                  pageBuilder: (context, anim1, anim2) {
                                    return StatefulBuilder(builder:
                                        (context, StateSetter setState) {
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 30,
                                              left: 20,
                                              right: 20,
                                              bottom: 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Languages.of(context).quantity,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                              SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    setState(() {
                                                      quantityType[position] =
                                                          "2";
                                                      selectQuantityHalf[
                                                          position] = false;
                                                      selectQuantityFull[
                                                          position] = true;
                                                      itemTotal[position] =
                                                          menuListData[position]
                                                              .fullPrice;
                                                    });
                                                  });
                                                },
                                                child: Material(
                                                  color: Colors.white,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                            ),
                                                            selectQuantityFull[
                                                                    position]
                                                                ? Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                        SizedBox(width: 15),
                                                        (widget.cuisine ==
                                                                "Mixed")
                                                            ? Image.asset(
                                                                "assets/blue.png",
                                                                scale: 15,
                                                              )
                                                            : (widget.cuisine ==
                                                                    "Non-veg")
                                                                ? Image.asset(
                                                                    "assets/red.png",
                                                                    scale: 15,
                                                                  )
                                                                : Image.asset(
                                                                    "assets/green.png",
                                                                    scale: 15,
                                                                  ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          Languages.of(context)
                                                                  .full +
                                                              " ₹${specialMenuListItemData[position].fullPrice}",
                                                          //'Item Total ₹$itemTotal',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              /* (menuListItemData[position].halfPrice ==
                                                "0")
                                            ? SizedBox(height: 0)
                                            : SizedBox(height: 20),
                                        (menuListItemData[position].halfPrice ==
                                                "0")
                                            ? Container()
                                            : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    quantityType[position] =
                                                        "1";
                                                    selectQuantityHalf[
                                                        position] = true;
                                                    selectQuantityFull[
                                                        position] = false;
                                                    itemTotal[position] =
                                                        menuListData[position]
                                                            .halfPrice;
                                                  });
                                                },
                                                child: Material(
                                                  color: Colors.white,
                                                  child: Container(
                                                    //color: Colors.black12,
                                                    child: Row(
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                            ),
                                                            selectQuantityHalf[
                                                                    position]
                                                                ? Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                        SizedBox(width: 15),
                                                        Image.asset(
                                                          'assets/veg.png',
                                                          scale: 15,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          Languages.of(context)
                                                                  .half +
                                                              ' ₹${menuListItemData[position].halfPrice}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),*/
                                              Spacer(),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Container(
                                                  height: 80,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Material(
                                                        child: Text(
                                                          (quantityType[
                                                                      position] ==
                                                                  "1")
                                                              ? 'Half'
                                                              : 'Full',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          if (selectQuantityHalf[
                                                                  position] ==
                                                              true) {
                                                            setState(() {
                                                              selectQuantityAmount =
                                                                  menuListData[
                                                                          position]
                                                                      .halfPrice;
                                                            });
                                                          } else if (selectQuantityFull[
                                                                  position] ==
                                                              true) {
                                                            setState(() {
                                                              selectQuantityAmount =
                                                                  menuListData[
                                                                          position]
                                                                      .fullPrice;
                                                            });
                                                          }
                                                          print(
                                                              "${quantityType[position]}");
                                                          if (quantityType[
                                                                      position] ==
                                                                  "1" ||
                                                              quantityType[
                                                                      position] ==
                                                                  "2") {
                                                            getAddItemData(
                                                                    widget
                                                                        .userId,
                                                                    menuListData[
                                                                            position]
                                                                        .id,
                                                                    selectQuantityAmount,
                                                                    quantityType[
                                                                        position],
                                                                    widget
                                                                        .kitchenId)
                                                                .then((value) {
                                                              getCart(widget
                                                                      .userId)
                                                                  .then(
                                                                      (value) {
                                                                print(
                                                                    "Cart Count: ${value.cart.length}");
                                                                c.upCartCount(value
                                                                    .cart.length
                                                                    .toString());
                                                                updateCartCount(
                                                                    value.cart
                                                                        .length
                                                                        .toString());
                                                              });
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Item added in cart",
                                                                fontSize: 20,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                              );
                                                            });
                                                          } else {
                                                            Fluttertoast
                                                                .showToast(
                                                              msg: "Try Again",
                                                              fontSize: 20,
                                                              textColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                            );
                                                          }

                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //     builder: (context) => BillDetailsScreen(),
                                                          //   ),
                                                          // );
                                                        },
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.green[800],
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20),
                                                            height:
                                                                50, //MediaQuery.of(context).size.height,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  selectQuantityFull[
                                                                          position]
                                                                      ? Languages.of(context)
                                                                              .total +
                                                                          ' ₹${specialMenuListItemData[position].fullPrice}'
                                                                      : Languages.of(context)
                                                                              .total +
                                                                          ' ₹${specialMenuListItemData[position].halfPrice}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  Languages.of(
                                                                          context)
                                                                      .addItem,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            //color: Colors.transparent,
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  transitionBuilder:
                                      (context, anim1, anim2, child) {
                                    return SlideTransition(
                                      position: Tween(
                                              begin: Offset(0, 1),
                                              end: Offset(0, 0))
                                          .animate(anim1),
                                      child: child,
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20),
                                    //color: Colors.white,
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                    ),
                                  ),
                                  Text(
                                    Languages.of(context).add + ' +',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
          );
  }

  Widget bulkOrderList(List<MenuList> menuListItemData, String kitchenId) {
    final c = context.watch<CartCount>();
    //print("Length: ${menuListItemData.length}");
    return Container(
      height: 200,
      child: Center(
        child: Text(
          Languages.of(context).emptyList,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  // Widget categoryList(List<CategoryList> categoryListData, String kitchenId) {
  //   return ListView.builder(
  //     //physics: BouncingScrollPhysics(),
  //     physics: ScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: categoryListData.length,
  //     itemBuilder: (context, position) {
  //       return /* menuListData.length == 0
  //           ? Center(
  //               child: Text(Languages.of(context).emptyList),
  //             )
  //           : */
  //           GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             category = categoryListData[position].id;
  //             //initState();
  //             getData();
  //           });
  //           //initState();
  //           Navigator.pop(context);
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  //           child: Container(
  //             height: 30,
  //             color: Colors.transparent,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('${categoryListData[position].name}'),
  //                 Text('${categoryListData[position].count}'),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  var pic;
  //bool showPic = false;

  Widget kitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    setState(() {
      bytes = base64Decode(logo);
    });

    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
      //child: Image.memory(bytes),
    );
  }

  getData() {
    getMenuListData(widget.kitchenId).then((value) {
      menuListData = value;
      for (int i = 0; i < menuListData.length; i++) {
        setState(() {
          itemTotal.add(menuListData[i].halfPrice);
          quantityType.add("2");
          selectQuantityHalf.add(false);
          selectQuantityFull.add(true);
          selectMenuItem.add(false);
        });
      }
      // setState(() {});
    });
  }

  String cartCount = "0";
  int _current = 0;

  void updateCartCount(String _count) {
    setState(() => cartCount = _count);
  }

  void initState() {
    // PushNotification().initialize();
    string1 = 'assets/svg/Icon feather-home.svg';
    string2 = 'assets/svg/blog.svg';
    string3 = 'assets/svg/register kitchen.svg';
    string4 = 'assets/svg/Icon feather-user.svg';
    getMenuList(widget.kitchenId);
    address = widget.kitchenLocation.split(",");
    // getMenuCategoryList(widget.kitchenId, category);
    getData();
    print("userid: ${widget.userId}");
    print("kitchenId: ${widget.kitchenId}");
    print("favorite: ${widget.fav}");
    print("Cuisine: ${widget.cuisine}");
    print("Banner Image: ${widget.bnImage}");

    if (widget.fav == "0" || widget.fav == null) {
      setState(() {
        isfav = false;
      });
    } else if (widget.fav == "1") {
      setState(() {
        isfav = true;
      });
    }
    getCart(widget.userId).then((value) {
      print("Cart Count: ${value.cart.length}");
      updateCartCount(value.cart.length.toString());
    });
    print("isFav: $isfav");
    pic = kitchenLogo(widget.logo);

    getCouponList(
      widget.lat,
      widget.long,
    ).then((value) {
      // for (int i = 0; i < value.data!.length; i++) {
      //   imgList.add(value.data![i].image!);
      // }
      setState(() {
        // imgList.add(value.data![0].image!);
        for (int i = 0; i < value.length; i++) {
          if (value[i].imageData.length > 15) {
            imgList.add(value[i].imageData);
            // imgId.add(value[i].id);
          } else {
            imgList.add(noImageUrl);
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //bool isFav;
    final List<Widget> imageSliders = imgList
        .map((item) => GestureDetector(
              onTap: () {
                int index = imgList.indexOf(item);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             ProductDetailScreen(imgId[index], widget.userId)));
              },
              child: Container(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  // elevation: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network(item, fit: BoxFit.fill, width: 1000.0),
                  ),
                ),
              ),
            ))
        .toList();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.dark,
        shadowColor: Colors.black87,
        actions: [
          InkWell(
            onTap: () {
              if (isfav == false) {
                setState(() {
                  favorite = "1";
                  isfav = true;
                });

                getFavoriteKitchenData(
                        widget.userId, widget.kitchenId, favorite)
                    .then((value) {
                  print("Favorite Response: ${value.message}");
                });
              } else if (isfav == true) {
                setState(() {
                  favorite = "0";
                  isfav = false;
                });

                getFavoriteKitchenData(
                        widget.userId, widget.kitchenId, favorite)
                    .then((value) {
                  print("Favorite Response: ${value.message}");
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: isfav
                  ? SvgPicture.asset('assets/svg/Icon awesome-heart-red.svg')
                  : SvgPicture.asset('assets/svg/Icon awesome-heart.svg'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 250),
                (imgList.length == 0)
                    ? Container()
                    : Container(
                        // color: Colors.black26,
                        child: Column(
                          children: [
                            CarouselSlider(
                              // carouselController: controller,
                              items: imageSliders,
                              options: CarouselOptions(
                                height: 120,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 5),
                                enlargeCenterPage: true,
                                aspectRatio: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                    // controller = index;
                                  });
                                  print("Current: $_current");
                                },
                                // onPageChanged: (index, reason) {},
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.map((url) {
                                int index = imgList.indexOf(url);
                                return imgList.length != 1
                                    ? Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 3.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: index == _current
                                              ? Colors.black
                                              : Colors.black26,
                                        ),
                                      )
                                    : Container();
                              }).toList(),
                            ),
                          ],
                        ),
                        /*child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Material(
                          //elevation: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('assets/Offer.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Material(
                          //elevation: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('assets/Offer.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/
                      ),
                SizedBox(height: (imgList.length == 0) ? 0 : 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            click1 = true;
                            click2 = false;
                            click3 = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 30) / 3,
                          child: click1
                              ? Container(
                                  height: 50,
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          3,
                                  decoration: BoxDecoration(
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
                                    child: Text(
                                      // Languages.of(context).current,
                                      "Regular Menu",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  color: Colors.transparent,
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          3,
                                  child: Center(
                                    child: Text(
                                      // Languages.of(context).current,
                                      "Regular Menu",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            click1 = false;
                            click2 = true;
                            click3 = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 30) / 3,
                          child: click2
                              ? Container(
                                  height: 50,
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          3,
                                  decoration: BoxDecoration(
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
                                    child: Text(
                                      // Languages.of(context).closed,
                                      "Special Menu",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  color: Colors.transparent,
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          3,
                                  child: Center(
                                    child: Text(
                                      // Languages.of(context).closed,
                                      "Special Menu",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            click1 = false;
                            click2 = false;
                            click3 = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 30) / 3,
                          child: click3
                              ? Container(
                                  height: 50,
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          3,
                                  decoration: BoxDecoration(
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
                                    child: Text(
                                      // Languages.of(context).current,
                                      "Bulk Order",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  color: Colors.transparent,
                                  width:
                                      (MediaQuery.of(context).size.width - 30) /
                                          3,
                                  child: Center(
                                    child: Text(
                                      // Languages.of(context).current,
                                      "Bulk Order",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                //menu(),
                SizedBox(height: 10),
                click3
                    ? bulkOrderList([], "")
                    : click2
                        ? FutureBuilder(
                            future: getSpecialMenuListData(widget.kitchenId),
                            builder: (context, snapshot) {
                              return snapshot.data != null
                                  ? specialMenuList(
                                      snapshot.data, widget.userId)
                                  : Container(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                            },
                          )
                        : FutureBuilder(
                            future: getMenuListData(widget.kitchenId),
                            builder: (context, snapshot) {
                              return snapshot.data != null
                                  ? menuList(snapshot.data, widget.userId)
                                  : Container(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                            },
                          ),
              ],
            ),
          ),
          Container(
            height: 325,
            color: Colors.red[50],
            // color: Colors.black26,
            child: Column(
              children: [
                SizedBox(height: 180),
                Container(
                  // color: Colors.black12,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 0),
                            (widget.cuisine == "Mixed")
                                ? Image.asset(
                                    "assets/blue.png",
                                    scale: 15,
                                  )
                                : (widget.cuisine == "Non-veg")
                                    ? Image.asset(
                                        "assets/red.png",
                                        scale: 15,
                                      )
                                    : Image.asset(
                                        "assets/green.png",
                                        scale: 15,
                                      ),
                            // SvgPicture.asset('assets/svg/green.svg'),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                '${widget.kitchenName}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                '${widget.kitchenLocation}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                (widget.kitchenRating == null)
                                    ? Container()
                                    : SvgPicture.asset(
                                        'assets/svg/Shape -1.svg',
                                        width: 14,
                                      ),
                                SizedBox(width: 5),
                                (widget.kitchenRating == null)
                                    ? Container()
                                    : Text(
                                        '${widget.kitchenRating.substring(0, 3)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                (widget.kitchenRating == null)
                                    ? Container()
                                    : SizedBox(width: 10),
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
                          ],
                        ),
                        // Material(
                        //   elevation: 5,
                        //   borderRadius: BorderRadius.circular(50),
                        //   child: Image.asset(
                        //     'assets/o2jbchmu.png',
                        //     scale: 1.5,
                        //   ),
                        // )
                        // kitchenLogo(widget.logo)
                        pic,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: (widget.bnImage != "null")
                  image: NetworkImage(
                      widget.bnImage != null ? widget.bnImage : noImageUrl),
                  // : AssetImage("assets/Indain Veg Thali.png"),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Image.asset(
              //   'assets/Indain Veg Thali.png',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          /*Column(
            // shrinkWrap: true,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           SizedBox(height: 0),
              //           (widget.cuisine == "Mixed")
              //               ? Image.asset(
              //                   "assets/blue.png",
              //                   scale: 15,
              //                 )
              //               : (widget.cuisine == "Non-veg")
              //                   ? Image.asset(
              //                       "assets/red.png",
              //                       scale: 15,
              //                     )
              //                   : Image.asset(
              //                       "assets/green.png",
              //                       scale: 15,
              //                     ),
              //           // SvgPicture.asset('assets/svg/green.svg'),
              //           SizedBox(height: 5),
              //           Container(
              //             width: MediaQuery.of(context).size.width * 0.6,
              //             child: Text(
              //               '${widget.kitchenName}',
              //               style: TextStyle(
              //                 fontSize: 22,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //           SizedBox(height: 5),
              //           Container(
              //             width: MediaQuery.of(context).size.width * 0.65,
              //             child: Text(
              //               '${widget.kitchenLocation}',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //           SizedBox(height: 5),
              //           Row(
              //             children: [
              //               (widget.kitchenRating == null)
              //                   ? Container()
              //                   : SvgPicture.asset(
              //                       'assets/svg/Shape -1.svg',
              //                       width: 14,
              //                     ),
              //               SizedBox(width: 5),
              //               (widget.kitchenRating == null)
              //                   ? Container()
              //                   : Text(
              //                       '${widget.kitchenRating.substring(0, 3)}',
              //                       style: TextStyle(
              //                         fontSize: 12,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //               (widget.kitchenRating == null)
              //                   ? Container()
              //                   : SizedBox(width: 10),
              //               SvgPicture.asset('assets/svg/clock.svg'),
              //               SizedBox(width: 5),
              //               Text(
              //                 '40 min',
              //                 style: TextStyle(
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //       // Material(
              //       //   elevation: 5,
              //       //   borderRadius: BorderRadius.circular(50),
              //       //   child: Image.asset(
              //       //     'assets/o2jbchmu.png',
              //       //     scale: 1.5,
              //       //   ),
              //       // )
              //       // kitchenLogo(widget.logo)
              //       pic,
              //     ],
              //   ),
              // ),
              // SizedBox(height: 310),
              Container(
                // color: Colors.black26,
                child: CarouselSlider(
                  // carouselController: controller,
                  items: imageSliders,
                  options: CarouselOptions(
                    height: 120,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    enlargeCenterPage: true,
                    aspectRatio: 1.0,
                    // onPageChanged: (index, reason) {},
                  ),
                ),
                /*child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Material(
                          //elevation: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('assets/Offer.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Material(
                          //elevation: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('assets/Offer.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          click1 = true;
                          click2 = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        child: click1
                            ? Container(
                                height: 50,
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        2,
                                decoration: BoxDecoration(
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
                                  child: Text(
                                    // Languages.of(context).current,
                                    "Regular Menu",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              )
                            : Container(
                                height: 50,
                                color: Colors.transparent,
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        2,
                                child: Center(
                                  child: Text(
                                    // Languages.of(context).current,
                                    "Regular Menu",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          click1 = false;
                          click2 = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        child: click2
                            ? Container(
                                height: 50,
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        2,
                                decoration: BoxDecoration(
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
                                  child: Text(
                                    // Languages.of(context).closed,
                                    "Special Menu",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              )
                            : Container(
                                height: 50,
                                color: Colors.transparent,
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        2,
                                child: Center(
                                  child: Text(
                                    // Languages.of(context).closed,
                                    "Special Menu",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              //menu(),
              SizedBox(height: 10),
              FutureBuilder(
                future: getMenuListData(widget.kitchenId),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? menuList(snapshot.data, widget.userId)
                      : Container(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                },
              ),
              // SizedBox(height: 20),
              // SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              //   child: Text(
              //     'Recommended',
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              // FutureBuilder(
              //   future: getMenuListData(widget.userId),
              //   builder: (context, snapshot) {
              //     return snapshot.data != null
              //         ? menuList(snapshot.data, widget.userId)
              //         : Center(
              //             child: CircularProgressIndicator(),
              //           );
              //   },
              // ),
              // SizedBox(height: 10),
            ],
          ),*/
          // Second stack item
          /*Container(
            height: 385,
            color: Colors.red[50],
            child: Column(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: (widget.bnImage != "null")
                        image: NetworkImage(widget.bnImage != null
                            ? widget.bnImage
                            : noImageUrl),
                        // : AssetImage("assets/Indain Veg Thali.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Image.asset(
                    //   'assets/Indain Veg Thali.png',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -40),
                  child: Container(
                    // color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 0),
                              (widget.cuisine == "Mixed")
                                  ? Image.asset(
                                      "assets/blue.png",
                                      scale: 15,
                                    )
                                  : (widget.cuisine == "Non-veg")
                                      ? Image.asset(
                                          "assets/red.png",
                                          scale: 15,
                                        )
                                      : Image.asset(
                                          "assets/green.png",
                                          scale: 15,
                                        ),
                              // SvgPicture.asset('assets/svg/green.svg'),
                              SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  '${widget.kitchenName}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  '${widget.kitchenLocation}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  (widget.kitchenRating == null)
                                      ? Container()
                                      : SvgPicture.asset(
                                          'assets/svg/Shape -1.svg',
                                          width: 14,
                                        ),
                                  SizedBox(width: 5),
                                  (widget.kitchenRating == null)
                                      ? Container()
                                      : Text(
                                          '${widget.kitchenRating.substring(0, 3)}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                  (widget.kitchenRating == null)
                                      ? Container()
                                      : SizedBox(width: 10),
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
                            ],
                          ),
                          // Material(
                          //   elevation: 5,
                          //   borderRadius: BorderRadius.circular(50),
                          //   child: Image.asset(
                          //     'assets/o2jbchmu.png',
                          //     scale: 1.5,
                          //   ),
                          // )
                          // kitchenLogo(widget.logo)
                          pic,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),*/
          //Browse Menu button
          // GestureDetector(
          //   onTap: () {
          //     showDialog(
          //       //barrierDismissible: false,
          //       context: context,
          //       builder: (context) {
          //         return StatefulBuilder(
          //           builder: (context, StateSetter setState) {
          //             return Dialog(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               //insetAnimationCurve: Curves.bounceIn,
          //               child: Padding(
          //                 padding: const EdgeInsets.symmetric(vertical: 20),
          //                 child: FutureBuilder(
          //                   future: getCategoryListData(widget.kitchenId),
          //                   builder: (context, snapshot) {
          //                     return snapshot.data != null
          //                         ? categoryList(snapshot.data, widget.userId)
          //                         : Container(
          //                             child: Center(
          //                               child: CircularProgressIndicator(),
          //                             ),
          //                           );
          //                   },
          //                 ),
          //               ),
          //             );
          //           },
          //         );
          //       },
          //     );
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //     //color: Colors.amber,
          //     child: Column(
          //       children: [
          //         Spacer(),
          //         SvgPicture.asset('assets/svg/Group 1994.svg'),
          //         SizedBox(height: 10),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      // extendBody: (cartCount == "0") ? true : false,
      bottomNavigationBar: (cartCount == "0")
          ? Container(
              height: 0,
            )
          : Container(
              padding: const EdgeInsets.all(20),
              color: Colors.transparent,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "You have $cartCount items in your cart",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(widget.userId),
                        ),
                      );
                    },
                    child: Text(
                      "View",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      //bottomNavigationBar:
      //  BottomBar(string1, string2, string3, string4, widget.address),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 120);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 120);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
