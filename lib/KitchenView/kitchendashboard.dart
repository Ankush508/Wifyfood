import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/CommonFunctions.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/collapsing_navigation_drawer.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/KitchenHandlers/dashboard_kitchen.dart';
import 'package:wifyfood/KitchenHandlers/outgoing_call_to_connect.dart';
import 'package:wifyfood/KitchenView/orderdeliveredscreen.dart';
import 'package:wifyfood/KitchenView/orderreceivedscreen.dart';
import 'package:wifyfood/KitchenView/signinscreen.dart';
import 'package:wifyfood/KitchenHandlers/kitchen_profile.dart';
import 'package:wifyfood/KitchenHandlers/online_offline.dart';
import 'package:wifyfood/KitchenHandlers/order_status.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/KitchenView/notificationscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class KitchenDashboard extends StatefulWidget {
  @override
  _KitchenDashboardState createState() => _KitchenDashboardState();
}

class _KitchenDashboardState extends State<KitchenDashboard> {
  List<bool> isClickToday = [];
  List<bool> isClickPending = [];
  bool click1 = true;
  bool click2 = false;
  List<bool> isAccept = [];
  List<bool> isReject = [];
  List<bool> isCooking = [];
  List<bool> isComplete = [];
  String kitchenName = "";
  String email = "";
  String logo = "";
  String cuisine;
  String kid;
  String totalOrder = "0";
  String monthlyOrder = "0";
  String todayEarning = "0";
  String monthlyEarning = "0";
  List<bool> isSelected;
  bool isOnline = false;
  Timer timer;
  // StreamController _pendingDataController = StreamController();
  // int count = 1;
  // pendingData() async {
  //   getPendingOrdersListData(kid, count * 5).then((res) async {
  //     print("pendingData");
  //     _pendingDataController.add(res);
  //     // return res;
  //   });
  // }

  Widget todayOrders(List<TodayOrders> todOrders, String kitchenId) {
    return (todOrders.length == 0)
        ? Container(
            height: 100,
            child: Center(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: todOrders.length,
            itemBuilder: (BuildContext context, int position) {
              isClickToday.add(false);
              isAccept.add(false);
              isReject.add(false);
              return isClickToday[position]
                  ? Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      //color: Colors.red[100],
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                            //color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isClickToday[position] == false) {
                                      isClickToday[position] = true;
                                    } else if (isClickToday[position] == true) {
                                      isClickToday[position] = false;
                                    }
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 5),
                                      Container(
                                        //color: Colors.black12,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    20) *
                                                0.2,
                                        height: 100,
                                        child: Center(
                                          child: Container(
                                            width: ((MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        20) *
                                                    0.2) *
                                                0.85,
                                            height: ((MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        20) *
                                                    0.2) *
                                                0.85,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  245, 146, 33, 100),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: ((MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20) *
                                                        0.2) *
                                                    0.7,
                                                height: ((MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20) *
                                                        0.2) *
                                                    0.7,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      245, 146, 33, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      Languages.of(context)
                                                          .bill,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${todOrders[position].totalPrice}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //color: Colors.black12,
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        //color: Colors.black26,
                                        //width: (MediaQuery.of(context).size.width - 20) * 0.45,
                                        height: 120,
                                        //color: Colors.black26,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Order Id: ${todOrders[position].orderId}",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "${todOrders[position].fullName} " +
                                                  "${todOrders[position].lastName}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Text(
                                                  "Quantity: ${todOrders[position].orderQuntity}",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                SizedBox(width: 4),
                                                SvgPicture.asset(
                                                  'assets/svg/clock.svg',
                                                  width: 8,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  "Time Remaining : ",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                Text(
                                                  "30min",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            SizedBox(
                                              height: 22,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.75,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: todOrders[position]
                                                      .menu
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 2),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${todOrders[position].menu[index].dishName}  " +
                                                                    "x" +
                                                                    "${todOrders[position].menu[index].quantity}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                              Text(
                                                                (todOrders[position]
                                                                            .menu[index]
                                                                            .priceType ==
                                                                        "2")
                                                                    ? "Full"
                                                                    : "Half",
                                                                style: TextStyle(
                                                                    fontSize: 6,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(24, 0),
                                child: Container(
                                  //width: (MediaQuery.of(context).size.width - 20) * 0.35,
                                  width: 220,
                                  height: 120,
                                  // color: Colors.black12,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Status",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isAccept[position] = true;
                                                isReject[position] = false;
                                                isClickToday[position] = false;
                                                getOrderStatusData(
                                                        todOrders[position]
                                                            .orderId,
                                                        "1")
                                                    .then((value) {
                                                  setState(() {});
                                                  Fluttertoast.showToast(
                                                    msg: "Order Accepted",
                                                    fontSize: 20,
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                  );
                                                });
                                              });
                                            },
                                            child: Container(
                                              width: ((MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              20) *
                                                          0.5) /
                                                      2 -
                                                  5,
                                              height: 20,
                                              //color: Colors.yellow[100],
                                              child: Row(
                                                children: [
                                                  isAccept[position]
                                                      ? Container(
                                                          width: 15,
                                                          height: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      146,
                                                                      33,
                                                                      1),
                                                              width: 4,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 15,
                                                          height: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    Languages.of(context)
                                                        .accept,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isAccept[position] = false;
                                                isReject[position] = true;
                                                getOrderStatusData(
                                                        todOrders[position]
                                                            .orderId,
                                                        "2")
                                                    .then((value) {
                                                  setState(() {});
                                                  Fluttertoast.showToast(
                                                    msg: "Order Rejected",
                                                    fontSize: 20,
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                  );
                                                });
                                              });
                                            },
                                            child: Container(
                                              width: ((MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          20) *
                                                      0.5) /
                                                  2,
                                              height: 20,
                                              //color: Colors.blue[100],
                                              child: Row(
                                                children: [
                                                  isReject[position]
                                                      ? Container(
                                                          width: 15,
                                                          height: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      146,
                                                                      33,
                                                                      1),
                                                              width: 4,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 15,
                                                          height: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    Languages.of(context)
                                                        .reject,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      (todOrders[position].orderStatus == "0")
                                          ? Container()
                                          : Text(
                                              "Order Update",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                      SizedBox(height: 5),
                                      (todOrders[position].orderStatus == "0")
                                          ? Container()
                                          : Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      // if (todOrders[position].orderStatus ==
                                                      //     "3") {
                                                      //   isAccept[position] = false;
                                                      //   isReject[position] = false;
                                                      // }
                                                    });
                                                  },
                                                  child: Container(
                                                    width: ((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    20) *
                                                                0.5) /
                                                            2 -
                                                        5,
                                                    height: 20,
                                                    //color: Colors.yellow[100],
                                                    child: Row(
                                                      children: [
                                                        // isCooking
                                                        //     ? Container(
                                                        //         width: 15,
                                                        //         height: 15,
                                                        //         decoration: BoxDecoration(
                                                        //           color: Colors.white,
                                                        //           borderRadius:
                                                        //               BorderRadius.circular(
                                                        //                   50),
                                                        //           border: Border.all(
                                                        //             color: Color.fromRGBO(
                                                        //                 245, 146, 33, 1),
                                                        //             width: 4,
                                                        //           ),
                                                        //         ),
                                                        //       )
                                                        //     :
                                                        Container(
                                                          width: 15,
                                                          height: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          Languages.of(context)
                                                              .cook,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      // if (todOrders[position].orderStatus ==
                                                      //     "4") {
                                                      //   isAccept[position] = false;
                                                      //   isReject[position] = false;
                                                      // }
                                                    });
                                                  },
                                                  child: Container(
                                                    width:
                                                        ((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    20) *
                                                                0.5) /
                                                            2,
                                                    height: 20,
                                                    //color: Colors.blue[100],
                                                    child: Row(
                                                      children: [
                                                        // isComplete
                                                        //     ? Container(
                                                        //         width: 15,
                                                        //         height: 15,
                                                        //         decoration: BoxDecoration(
                                                        //           color: Colors.white,
                                                        //           borderRadius:
                                                        //               BorderRadius.circular(
                                                        //                   50),
                                                        //           border: Border.all(
                                                        //             color: Color.fromRGBO(
                                                        //                 245, 146, 33, 1),
                                                        //             width: 4,
                                                        //           ),
                                                        //         ),
                                                        //       )
                                                        //     :
                                                        Container(
                                                          width: 15,
                                                          height: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          Languages.of(context)
                                                              .comp,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isClickToday[position] == false) {
                            isClickToday[position] = true;
                          } else if (isClickToday[position] == true) {
                            isClickToday[position] = false;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        //color: Colors.red[100],
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            //padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) *
                                          0.2,
                                  height: 100,
                                  child: Center(
                                    child: Container(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                      20) *
                                                  0.2) *
                                              0.85,
                                      height:
                                          ((MediaQuery.of(context).size.width -
                                                      20) *
                                                  0.2) *
                                              0.85,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(245, 146, 33, 100),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.2) *
                                              0.7,
                                          height: ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.2) *
                                              0.7,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(245, 146, 33, 1),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Languages.of(context).bill,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${todOrders[position].totalPrice}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //color: Colors.black12,
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) *
                                          0.45,
                                  height: 100,
                                  //color: Colors.black26,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Order Id: ${todOrders[position].orderId}",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${todOrders[position].fullName} " +
                                            "${todOrders[position].lastName}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            "Quantity: ${todOrders[position].orderQuntity}",
                                            style: TextStyle(fontSize: 7),
                                          ),
                                          SizedBox(width: 4),
                                          SvgPicture.asset(
                                            'assets/svg/clock.svg',
                                            width: 8,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "Time Remaining : ",
                                            style: TextStyle(fontSize: 7),
                                          ),
                                          Text(
                                            "30min",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) *
                                          0.35,
                                  height: 100,
                                  //color: Colors.black12,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Status",
                                        style: TextStyle(fontSize: 7),
                                      ),
                                      SizedBox(width: 2),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // setState(() {
                                              //   isAccept[position] = true;
                                              //   isReject[position] = false;
                                              // });
                                            },
                                            child: Container(
                                              width: ((MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              20) *
                                                          0.35) /
                                                      2 -
                                                  5,
                                              height: 20,
                                              //color: Colors.yellow[100],
                                              child: Row(
                                                children: [
                                                  isAccept[position]
                                                      ? Container(
                                                          width: 12,
                                                          height: 12,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      146,
                                                                      33,
                                                                      1),
                                                              width: 3,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 12,
                                                          height: 12,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    Languages.of(context)
                                                        .accept,
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // setState(() {
                                              //   isAccept[position] = false;
                                              //   isReject[position] = true;
                                              // });
                                            },
                                            child: Container(
                                              width: ((MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          20) *
                                                      0.35) /
                                                  2,
                                              height: 20,
                                              //color: Colors.blue[100],
                                              child: Row(
                                                children: [
                                                  isReject[position]
                                                      ? Container(
                                                          width: 12,
                                                          height: 12,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      146,
                                                                      33,
                                                                      1),
                                                              width: 3,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 12,
                                                          height: 12,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black12,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    Languages.of(context)
                                                        .reject,
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /* Text(
                                        "Order Update",
                                        style: TextStyle(fontSize: 7),
                                      ),
                                      SizedBox(width: 2),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: ((MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              20) *
                                                          0.35) /
                                                      2 -
                                                  5,
                                              height: 20,
                                              //color: Colors.yellow[100],
                                              child: Row(
                                                children: [
                                                  // isCooking
                                                  //     ? Container(
                                                  //         width: 12,
                                                  //         height: 12,
                                                  //         decoration: BoxDecoration(
                                                  //           color: Colors.white,
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(50),
                                                  //           border: Border.all(
                                                  //             color: Color.fromRGBO(
                                                  //                 245, 146, 33, 1),
                                                  //             width: 3,
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     :
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                        color: Colors.black12,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    Languages.of(context).cook,
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: ((MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          20) *
                                                      0.35) /
                                                  2,
                                              height: 20,
                                              //color: Colors.blue[100],
                                              child: Row(
                                                children: [
                                                  // isComplete
                                                  //     ? Container(
                                                  //         width: 12,
                                                  //         height: 12,
                                                  //         decoration: BoxDecoration(
                                                  //           color: Colors.white,
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(50),
                                                  //           border: Border.all(
                                                  //             color: Color.fromRGBO(
                                                  //                 245, 146, 33, 1),
                                                  //             width: 3,
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     :
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                        color: Colors.black12,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    Languages.of(context).comp,
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            });
  }

  Widget pendingOrders(List<PendingOrders> penOrders, String kitchenId) {
    //print("Len: ${todOrders.length}");
    return (penOrders.length == 0)
        ? Container(
            height: 100,
            child: Center(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: penOrders.length,
            itemBuilder: (BuildContext context, int position) {
              isClickPending.add(false);
              isAccept.add(false);
              isReject.add(false);
              isCooking.add(false);
              isComplete.add(false);
              return isClickPending[position]
                  ? Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: (penOrders[position].dmob == null) ? 280 : 380,
                      //color: Colors.red[100],
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                            //color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isClickPending[position] == false) {
                                      isClickPending[position] = true;
                                    } else if (isClickPending[position] ==
                                        true) {
                                      isClickPending[position] = false;
                                    }
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 5),
                                      Container(
                                        //color: Colors.black12,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    20) *
                                                0.2,
                                        height: 100,
                                        child: Center(
                                          child: Container(
                                            width: ((MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        20) *
                                                    0.2) *
                                                0.85,
                                            height: ((MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        20) *
                                                    0.2) *
                                                0.85,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  245, 146, 33, 100),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: ((MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20) *
                                                        0.2) *
                                                    0.7,
                                                height: ((MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20) *
                                                        0.2) *
                                                    0.7,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      245, 146, 33, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      Languages.of(context)
                                                          .bill,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${penOrders[position].totalPrice}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //color: Colors.black12,
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        //color: Colors.black26,
                                        //width: (MediaQuery.of(context).size.width - 20) * 0.45,
                                        height: 120,
                                        //color: Colors.black26,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Order Id: ${penOrders[position].orderId}",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "${penOrders[position].fullName} " +
                                                  "${penOrders[position].lastName}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Text(
                                                  "Quantity: ${penOrders[position].orderQuntity}",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                SizedBox(width: 4),
                                                Image.asset(
                                                  'assets/Vector Smart Object-12.png',
                                                  scale: 1.5,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  "Time Remaining : ",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                Text(
                                                  "30min",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            SizedBox(
                                              height: 22,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.75,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: penOrders[position]
                                                      .menu
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 2),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${penOrders[position].menu[index].dishName}  " +
                                                                    "x" +
                                                                    "${penOrders[position].menu[index].quantity}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                              Text(
                                                                (penOrders[position]
                                                                            .menu[index]
                                                                            .priceType ==
                                                                        "2")
                                                                    ? "Full"
                                                                    : "Half",
                                                                style: TextStyle(
                                                                    fontSize: 6,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              (penOrders[position].orderStatus == "4")
                                  ? Container(
                                      width: 174,
                                      height: 120,
                                      child: Center(
                                        child: Container(
                                          height: 60,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.green,
                                              width: 4,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Completed",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : (penOrders[position].orderStatus == "2")
                                      ? Container(
                                          width: 174,
                                          height: 120,
                                          child: Center(
                                            child: Container(
                                              height: 60,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 4,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Rejected",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : /*Container(
                                          width: 174,
                                          height: 120,
                                          child: Center(
                                            child: Container(
                                              height: 60,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.amber,
                                                  width: 4,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Pending",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.amber,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),*/
                                      Container(
                                          //width: (MediaQuery.of(context).size.width - 20) * 0.35,
                                          width: 190,
                                          height: 120,
                                          // color: Colors.black12,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              /*Text(
                                                "Status",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (penOrders[position]
                                                                .orderStatus ==
                                                            "1") {
                                                          isAccept[position] =
                                                              true;
                                                          isReject[position] =
                                                              false;
                                                          isCooking[position] =
                                                              false;
                                                          isComplete[position] =
                                                              false;
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      width: ((MediaQuery.of(context)
                                                                          .size
                                                                          .width -
                                                                      20) *
                                                                  0.5) /
                                                              2 -
                                                          5,
                                                      height: 20,
                                                      //color: Colors.yellow[100],
                                                      child: Row(
                                                        children: [
                                                          (penOrders[position]
                                                                      .orderStatus !=
                                                                  "0")
                                                              ? Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color.fromRGBO(
                                                                          245,
                                                                          146,
                                                                          33,
                                                                          1),
                                                                      width: 4,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black12,
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                ),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            Languages.of(
                                                                    context)
                                                                .accept,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isAccept[position] =
                                                            false;
                                                        isReject[position] =
                                                            true;
                                                        isCooking[position] =
                                                            false;
                                                        isComplete[position] =
                                                            false;
                                                        getOrderStatusData(
                                                                penOrders[
                                                                        position]
                                                                    .orderId,
                                                                "2")
                                                            .then((value) {
                                                          setState(() {});
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Order Rejected",
                                                            fontSize: 20,
                                                            textColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.blue,
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                          );
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      width: ((MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  20) *
                                                              0.5) /
                                                          2,
                                                      height: 20,
                                                      //color: Colors.blue[100],
                                                      child: Row(
                                                        children: [
                                                          isReject[position]
                                                              ? Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color.fromRGBO(
                                                                          245,
                                                                          146,
                                                                          33,
                                                                          1),
                                                                      width: 4,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black12,
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                ),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            Languages.of(
                                                                    context)
                                                                .reject,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),*/
                                              // (penOrders[position]
                                              //                 .orderStatus ==
                                              //             "3" ||
                                              //         penOrders[position]
                                              //                 .orderStatus ==
                                              //             "4" ||
                                              //         penOrders[position]
                                              //                 .orderStatus ==
                                              //             "6")
                                              //     ?
                                              Text(
                                                "Order Update",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              // : Container(),
                                              SizedBox(height: 5),
                                              // (penOrders[position]
                                              //                 .orderStatus ==
                                              //             "3" ||
                                              //         penOrders[position]
                                              //                 .orderStatus ==
                                              //             "4" ||
                                              //         penOrders[position]
                                              //                 .orderStatus ==
                                              //             "6")
                                              //     ?
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isAccept[position] =
                                                            false;
                                                        isReject[position] =
                                                            false;
                                                        isCooking[position] =
                                                            true;
                                                        isComplete[position] =
                                                            false;
                                                        getOrderStatusData(
                                                                penOrders[
                                                                        position]
                                                                    .orderId,
                                                                "3")
                                                            .then((value) {
                                                          setState(() {});
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Start Cooking",
                                                            fontSize: 20,
                                                            textColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.blue,
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                          );
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      width: ((MediaQuery.of(context)
                                                                          .size
                                                                          .width -
                                                                      20) *
                                                                  0.5) /
                                                              2 -
                                                          5,
                                                      height: 20,
                                                      //color: Colors.yellow[100],
                                                      child: Row(
                                                        children: [
                                                          (penOrders[position]
                                                                      .orderStatus ==
                                                                  "3")
                                                              ? Container(
                                                                  width: 18,
                                                                  height: 18,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color.fromRGBO(
                                                                          245,
                                                                          146,
                                                                          33,
                                                                          1),
                                                                      width: 4,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black12,
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                ),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            Languages.of(
                                                                    context)
                                                                .cook,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isAccept[position] =
                                                            false;
                                                        isReject[position] =
                                                            false;
                                                        isCooking[position] =
                                                            false;
                                                        isComplete[position] =
                                                            true;
                                                        getOrderStatusData(
                                                                penOrders[
                                                                        position]
                                                                    .orderId,
                                                                "4")
                                                            .then((value) {
                                                          setState(() {});
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Order Complete",
                                                            fontSize: 20,
                                                            textColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.blue,
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                          );
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      width: ((MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  20) *
                                                              0.5) /
                                                          2,
                                                      height: 20,
                                                      //color: Colors.blue[100],
                                                      child: Row(
                                                        children: [
                                                          (penOrders[position]
                                                                      .orderStatus ==
                                                                  "4")
                                                              ? Container(
                                                                  width: 18,
                                                                  height: 18,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color.fromRGBO(
                                                                          245,
                                                                          146,
                                                                          33,
                                                                          1),
                                                                      width: 4,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .black12,
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                ),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            Languages.of(
                                                                    context)
                                                                .comp,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // : Container(),
                                            ],
                                          ),
                                        ),
                              // Delivery Boy Details
                              (penOrders[position].dmob == null)
                                  ? Container()
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Delivery By:",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                              (penOrders[position].dmob == null)
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          showPic
                                              ? Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    image: DecorationImage(
                                                      // image: MemoryImage(bytes),
                                                      image: AssetImage(
                                                          "assets/profile.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    // image: DecorationImage(
                                                    //   image: MemoryImage(bytes),
                                                    //   fit: BoxFit.cover,
                                                    // ),
                                                  ),
                                                  //child: Image.memory(bytes),
                                                ),
                                          // CircleAvatar(
                                          //   radius: 30,
                                          //   backgroundColor: Colors.white,
                                          //   backgroundImage: AssetImage(
                                          //     'assets/profile.png',
                                          //   ),
                                          // ),
                                          SizedBox(width: 10),
                                          Container(
                                            // color: Colors.black12,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${penOrders[position].dfname} ${penOrders[position].dlname}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                //SizedBox(height: 5),
                                                // Text(
                                                //   "${detail.email}",
                                                //   style: TextStyle(
                                                //       color: Colors.black,
                                                //       fontWeight: FontWeight.w300,
                                                //       fontSize: 14),
                                                // ),
                                                // Text(
                                                //   "delivery@mail.com",
                                                //   style: TextStyle(
                                                //       color: Colors.black,
                                                //       fontWeight:
                                                //           FontWeight.w300,
                                                //       fontSize: 14),
                                                //   maxLines: 1,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              getOutgoingCallData(kMob,
                                                      penOrders[position].dmob)
                                                  .then((value) {
                                                if (value.status == 1) {
                                                  Fluttertoast.showToast(
                                                    msg: "Calling...",
                                                    fontSize: 20,
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                  );
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Something went wrong!!",
                                                    fontSize: 20,
                                                    textColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                  );
                                                }
                                              });
                                            },
                                            child: Material(
                                              color: Colors.green[700],
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: Center(
                                                  child: Icon(
                                                    Icons
                                                        .phone_in_talk_outlined,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isClickPending[position] == false) {
                            isClickPending[position] = true;
                          } else if (isClickPending[position] == true) {
                            isClickPending[position] = false;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        //color: Colors.red[100],
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            //padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) *
                                          0.2,
                                  height: 100,
                                  child: Center(
                                    child: Container(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                      20) *
                                                  0.2) *
                                              0.85,
                                      height:
                                          ((MediaQuery.of(context).size.width -
                                                      20) *
                                                  0.2) *
                                              0.85,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(245, 146, 33, 100),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.2) *
                                              0.7,
                                          height: ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.2) *
                                              0.7,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(245, 146, 33, 1),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                Languages.of(context).bill,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${penOrders[position].totalPrice}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //color: Colors.black12,
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) *
                                          0.45,
                                  height: 100,
                                  //color: Colors.black26,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Order Id: ${penOrders[position].orderId}",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${penOrders[position].fullName} " +
                                            "${penOrders[position].lastName}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            "Quantity: ${penOrders[position].orderQuntity}",
                                            style: TextStyle(fontSize: 7),
                                          ),
                                          SizedBox(width: 4),
                                          SvgPicture.asset(
                                            'assets/svg/clock.svg',
                                            width: 8,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "Time Remaining : ",
                                            style: TextStyle(fontSize: 7),
                                          ),
                                          Text(
                                            "30min",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                (penOrders[position].orderStatus == "4")
                                    ? Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    20) *
                                                0.35,
                                        height: 100,
                                        child: Center(
                                          child: Container(
                                            width: 80,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.green,
                                                width: 4,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Completed",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : (penOrders[position].orderStatus == "2")
                                        ? Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20) *
                                                0.35,
                                            height: 100,
                                            child: Center(
                                              child: Container(
                                                width: 80,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.red,
                                                    width: 4,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Rejected",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20) *
                                                0.35,
                                            height: 100,
                                            child: Center(
                                              child: Container(
                                                width: 80,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.amber,
                                                    width: 4,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Pending",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.amber,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                /*Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20) *
                                                0.35,
                                            height: 100,
                                            //color: Colors.black12,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Status",
                                                  style: TextStyle(fontSize: 7),
                                                ),
                                                SizedBox(width: 2),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isAccept[position] =
                                                              true;
                                                          isReject[position] =
                                                              false;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: ((MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        20) *
                                                                    0.35) /
                                                                2 -
                                                            5,
                                                        height: 20,
                                                        //color: Colors.yellow[100],
                                                        child: Row(
                                                          children: [
                                                            (penOrders[position]
                                                                        .orderStatus !=
                                                                    "0")
                                                                ? Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color.fromRGBO(
                                                                            245,
                                                                            146,
                                                                            33,
                                                                            1),
                                                                        width:
                                                                            3,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              Languages.of(
                                                                      context)
                                                                  .accept,
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isAccept[position] =
                                                              false;
                                                          isReject[position] =
                                                              true;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    20) *
                                                                0.35) /
                                                            2,
                                                        height: 20,
                                                        //color: Colors.blue[100],
                                                        child: Row(
                                                          children: [
                                                            isReject[position]
                                                                ? Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color.fromRGBO(
                                                                            245,
                                                                            146,
                                                                            33,
                                                                            1),
                                                                        width:
                                                                            3,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              Languages.of(
                                                                      context)
                                                                  .reject,
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // (penOrders[position]
                                                //                 .orderStatus ==
                                                //             "3" ||
                                                //         penOrders[position]
                                                //                 .orderStatus ==
                                                //             "4" ||
                                                //         penOrders[position]
                                                //                 .orderStatus ==
                                                //             "6")
                                                //     ?
                                                Text(
                                                  "Order Update",
                                                  style: TextStyle(fontSize: 7),
                                                ),
                                                // : Container(),
                                                SizedBox(width: 2),
                                                // (penOrders[position]
                                                //                 .orderStatus ==
                                                //             "3" ||
                                                //         penOrders[position]
                                                //                 .orderStatus ==
                                                //             "4" ||
                                                //         penOrders[position]
                                                //                 .orderStatus ==
                                                //             "6")
                                                //     ?
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isCooking[position] =
                                                              true;
                                                          isComplete[position] =
                                                              false;
                                                          getOrderStatusData(
                                                                  penOrders[
                                                                          position]
                                                                      .orderId,
                                                                  "3")
                                                              .then((value) {
                                                            setState(() {});
                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  "Start Cooking",
                                                              fontSize: 20,
                                                              textColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                            );
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        width: ((MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        20) *
                                                                    0.35) /
                                                                2 -
                                                            5,
                                                        height: 20,
                                                        //color: Colors.yellow[100],
                                                        child: Row(
                                                          children: [
                                                            (penOrders[position]
                                                                        .orderStatus ==
                                                                    "3")
                                                                ? Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color.fromRGBO(
                                                                            245,
                                                                            146,
                                                                            33,
                                                                            1),
                                                                        width:
                                                                            3,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              Languages.of(
                                                                      context)
                                                                  .cook,
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isCooking[position] =
                                                              false;
                                                          isComplete[position] =
                                                              true;
                                                          getOrderStatusData(
                                                                  penOrders[
                                                                          position]
                                                                      .orderId,
                                                                  "4")
                                                              .then((value) {
                                                            setState(() {});
                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  "Order Complete",
                                                              fontSize: 20,
                                                              textColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors.blue,
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                            );
                                                          });
                                                        });
                                                      },
                                                      child: Container(
                                                        width: ((MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    20) *
                                                                0.35) /
                                                            2,
                                                        height: 20,
                                                        //color: Colors.blue[100],
                                                        child: Row(
                                                          children: [
                                                            (penOrders[position]
                                                                        .orderStatus ==
                                                                    "4")
                                                                ? Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color.fromRGBO(
                                                                            245,
                                                                            146,
                                                                            33,
                                                                            1),
                                                                        width:
                                                                            3,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black12,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              Languages.of(
                                                                      context)
                                                                  .comp,
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // : Container(),
                                              ],
                                            ),
                                          ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          );
  }

  bool isLoading = true;
  var pic;
  bool showPic = false;
  String kMob;
  // FirebaseMessaging _messaging = FirebaseMessaging();
  void rebuildAllWidgets(BuildContext context) {
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void initState() {
    //setState(() {});
    PushNotification().initializeKitchen(context);
    Future.delayed(Duration.zero, () async {
      setupData();
      timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        //   getPendingOrdersListData(kid);
        //  getTodayOrdersListData(kid);
        rebuildAllWidgets(context);
        getKitchenDashboardData(kid).then((value) {
          setState(() {
            totalOrder = value.todayOrder.toString();
            monthlyOrder = value.monthlyOrder.toString();
            todayEarning = value.todayEarn.toString();
            monthlyEarning = value.monthlyEarn.toString();
          });
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // _pendingDataController.close();
    timer.cancel();
    super.dispose();
  }

  setupData() {
    SetKitchenId().getKitchenMobLocal().then((value) {
      kMob = value;
      print("Kitchen Mobile: $kMob");
    });
    SetKitchenId().getKitchenIdLocal().then((value) {
      print("-------value: $value");
      kid = value;
      print("KitchenId from local: $kid");
      getKitchenProfileData(kid).then((value) {
        setState(() {
          kitchenName = value.response.kitchenName.toString();
          email = value.response.email.toString();
          logo = value.response.logo.toString();
          cuisine = value.response.cuisine;
          pic = kitchenLogo(logo);
          if (logo == "" || logo == null) {
            showPic = false;
          } else {
            showPic = true;
          }
          if (value.response.onlineoffline == "1") {
            isOnline = true;
            isSelected = [false, true];
          } else if (value.response.onlineoffline == "0") {
            isOnline = false;
            isSelected = [true, false];
          }
          isLoading = false;
        });
      });
      getKitchenDashboardData(kid).then((value) {
        setState(() {
          totalOrder = value.todayOrder.toString();
          monthlyOrder = value.monthlyOrder.toString();
          todayEarning = value.todayEarn.toString();
          monthlyEarning = value.monthlyEarn.toString();
        });
      });
    });
    //  getPendingOrdersListData(kid);
    //   getTodayOrdersListData(kid);
    isSelected = [true, false];
  }

  Widget kitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

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
    );
  }

  // bool _bellClick = false;

  @override
  Widget build(BuildContext context) {
    CommonFunctions.console("build loaded--------------------------------");
    final c = context.watch<CartCount>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Image.asset(
              'assets/Icon feather-menu.png',
              scale: 1.2,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          Languages.of(context).dash,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: SizedBox(
              width: 50,
              child: InkWell(
                onTap: () {
                  c.updateBell(false);
                  // GlobalVariable.c.updateBell(true);

                  // showNot();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(kid),
                    ),
                  );
                },
                child: KitchenBell(),
                // child: c.isBell
                //     ? Icon(Icons.notifications_active_outlined,
                //         color: Colors.deepOrange[800])
                //     : Icon(Icons.notifications_none_outlined,
                //         color: Colors.deepOrange[800]),
              ),
            ),
          ),
        ],
      ),
      drawer: CollapsingNavigationDrawer(kid, kitchenName, email, logo),
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
          isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SafeArea(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            //SizedBox(height: 20),
                            Container(
                              // color: Colors.black12,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    //color: Colors.black26,
                                    width: MediaQuery.of(context).size.width *
                                        0.68,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(height: 20),
                                        Container(
                                          //color: Colors.black26,
                                          // width: MediaQuery.of(context).size.width *
                                          //     0.55,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                //color: Colors.black26,
                                                //height: 50,
                                                // width: MediaQuery.of(context)
                                                //         .size
                                                //         .width *
                                                //     0.55,
                                                child: Expanded(
                                                  child: Text(
                                                    '$kitchenName',
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              // SvgPicture.asset(
                                              //     'assets/svg/green.svg'),
                                              // Image.asset(
                                              //   'assets/veg.png',
                                              //   scale: 15,
                                              // ),
                                              (cuisine == "Mixed")
                                                  ? Image.asset(
                                                      "assets/blue.png",
                                                      scale: 15,
                                                    )
                                                  : (cuisine == "Non-veg")
                                                      ? Image.asset(
                                                          "assets/red.png",
                                                          scale: 15,
                                                        )
                                                      : Image.asset(
                                                          "assets/green.png",
                                                          scale: 15,
                                                        ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          //color: Colors.black26,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                            '$email',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  showPic
                                      ? pic
                                      : Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            // image: DecorationImage(
                                            //   image: MemoryImage(bytes),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                        ),
                                  // kitchenLogo(logo),
                                  // KitchenLogo(logo),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.38,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                0.38) /
                                            2,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderReceivedScreen(kid),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30) /
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.38) /
                                                2,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 5, bottom: 5),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30) /
                                                  2,
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.38) /
                                                  2,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    40, 209, 149, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: ((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2) *
                                                            0.45 -
                                                        10,
                                                    height: ((MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.38) /
                                                            2) *
                                                        0.8,
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                          'assets/svg/order-food.svg'),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    width: ((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2) *
                                                            0.55 -
                                                        10,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.38) /
                                                            2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '$totalOrder',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 32,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          Languages.of(context)
                                                              .ord,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                        Text(
                                                          Languages.of(context)
                                                              .rec,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDeliveredScreen(kid),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30) /
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.38) /
                                                2,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, bottom: 5),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30) /
                                                  2,
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.38) /
                                                  2,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    255, 72, 96, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: ((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2) *
                                                            0.45 -
                                                        10,
                                                    height: ((MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.38) /
                                                            2) *
                                                        0.8,
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                          'assets/svg/food-delivery.svg'),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    width: ((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    30) /
                                                                2) *
                                                            0.55 -
                                                        10,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.38) /
                                                            2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '$monthlyOrder',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 32,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          Languages.of(context)
                                                              .ord,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                        Text(
                                                          Languages.of(context)
                                                              .del,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                0.38) /
                                            2,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30) /
                                              2,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.38) /
                                              2,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 5, top: 5),
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30) /
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.38) /
                                                2,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  30, 159, 243, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: ((MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  30) /
                                                              2) *
                                                          0.45 -
                                                      25,
                                                  height:
                                                      ((MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.38) /
                                                              2) *
                                                          0.8,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/money.svg'),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  width:
                                                      ((MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  30) /
                                                              2) *
                                                          0.6,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.38) /
                                                          2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "₹" + "$todayEarning",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 32,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        Languages.of(context)
                                                            .today,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      Text(
                                                        Languages.of(context)
                                                            .earn,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30) /
                                              2,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.38) /
                                              2,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 5, top: 5),
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30) /
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.38) /
                                                2,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 145, 72, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: ((MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  30) /
                                                              2) *
                                                          0.45 -
                                                      25,
                                                  height:
                                                      ((MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.38) /
                                                              2) *
                                                          0.8,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                        'assets/svg/money-1.svg'),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  width:
                                                      ((MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  30) /
                                                              2) *
                                                          0.6,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.38) /
                                                          2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "₹" + '$monthlyEarning',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 32,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        Languages.of(context)
                                                            .mon,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      Text(
                                                        Languages.of(context)
                                                            .earn,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                Languages.of(context).kit,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOnline = !isOnline;
                                    if (isOnline == true) {
                                      getOnlineOfflineData(kid, 1);
                                    } else if (isOnline == false) {
                                      getOnlineOfflineData(kid, 2);
                                    }
                                  });
                                },
                                child: Container(
                                  width: 85,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          isOnline ? Colors.green : Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey[300],
                                  ),
                                  child: isOnline
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 2),
                                              Text(
                                                "Online",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                "Offline",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(width: 2),
                                            ],
                                          ),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                      // _pendingDataController.close();
                                    },
                                    child: Container(
                                      height: 50,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                      child: click1
                                          ? Container(
                                              height: 50,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30) /
                                                  2,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        224, 74, 34, 1),
                                                    Color.fromRGBO(
                                                        219, 47, 35, 1)
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  Languages.of(context)
                                                      .todayOrder,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 50,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30) /
                                                  2,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Text(
                                                  Languages.of(context)
                                                      .todayOrder,
                                                  style:
                                                      TextStyle(fontSize: 18),
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
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                      child: click2
                                          ? Container(
                                              height: 50,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30) /
                                                  2,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        224, 74, 34, 1),
                                                    Color.fromRGBO(
                                                        219, 47, 35, 1)
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  Languages.of(context)
                                                      .penOrder,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 50,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30) /
                                                  2,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Text(
                                                  Languages.of(context)
                                                      .penOrder,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            click1 // Today's Orders
                                ? FutureBuilder(
                                    future: getTodayOrdersListData(kid),
                                    builder: (context, snapshot) {
                                      // CommonFunctions.console("snapshot data" + snapshot.data);
                                      return snapshot.data != null
                                          ? todayOrders(snapshot.data, kid)
                                          : Container(
                                              height: 100,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                    },
                                  )
                                : // Pending Orders
                                FutureBuilder(
                                    future: getPendingOrdersListData(kid),
                                    builder: (context, snapshot) {
                                      return snapshot.data != null
                                          ? pendingOrders(snapshot.data, kid)
                                          : Container(
                                              height: 100,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                    },
                                  ),
                            // StreamBuilder(
                            //     stream: _pendingDataController.stream,
                            //     builder: (context, snapshot) {
                            //       return snapshot.data != null
                            //           ? pendingOrders(snapshot.data, kid)
                            //           : Container(
                            //               height: 100,
                            //               child: Center(
                            //                 child: CircularProgressIndicator(),
                            //               ),
                            //             );
                            //     },
                            //   ),
                            SizedBox(height: 20),
                          ],
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
