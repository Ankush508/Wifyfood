import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserHandlers/order_history.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/UserView/reviewscreen.dart';

class OrderHistoryScreen extends StatefulWidget {
  final String userId;
  OrderHistoryScreen(this.userId);
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<bool> click = [];

  Widget kitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: MemoryImage(bytes),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget orderHistory(List<Order> ord) {
    return (ord.length == 0)
        ? Center(
            child: Container(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
          )
        : ListView.builder(
            itemCount: ord.length,
            itemBuilder: (context, int position) {
              return GestureDetector(
                onTap: () {
                  if (click[position] == true) {
                    setState(() {
                      click[position] = false;
                    });
                  } else if (click[position] == false) {
                    setState(() {
                      click[position] = true;
                    });
                  }
                },
                child: Container(
                  color: (position.isEven) ? Colors.transparent : Colors.white,
                  child: click[position]
                      ? Container(
                          child: Column(
                            children: [
                              Padding(
                                // padding: EdgeInsets.only(
                                //     left: 20.0, right: 20.0, bottom: 20, top: 0),
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    kitchenLogo(ord[position].logo),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${ord[position].kitchenName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          // Text(
                                          //   'Lunch & Dinner Pack',
                                          //   style: TextStyle(
                                          //       fontSize: 14,
                                          //       //color: Colors.black87,
                                          //       fontWeight: FontWeight.w500),
                                          //   overflow: TextOverflow.ellipsis,
                                          //   maxLines: 1,
                                          // ),
                                          Text(
                                            "₹${ord[position].totPrice}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // RichText(
                                          //   text: TextSpan(
                                          //     text:
                                          //         'Dal + Butter Roti + Butter Paneer Masala + Gulab Jamun + Pulao + Aloo Vada',
                                          //     style: TextStyle(
                                          //         fontSize: 8,
                                          //         color: Colors.black87,
                                          //         fontWeight: FontWeight.w300),
                                          //     children: <TextSpan>[
                                          //       TextSpan(
                                          //         text: ' MORE',
                                          //         style: TextStyle(
                                          //             fontSize: 7,
                                          //             color: Colors.red,
                                          //             fontWeight: FontWeight.bold),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    //Spacer(),
                                    (ord[position].status == "5")
                                        ? Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Material(
                                                elevation: 5,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.red[700],
                                                child: Container(
                                                  height: 30,
                                                  width: 70,
                                                ),
                                              ),
                                              Text(
                                                'Cancelled',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Material(
                                                elevation: 5,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.green[800],
                                                child: Container(
                                                  height: 30,
                                                  width: 70,
                                                ),
                                              ),
                                              Text(
                                                'Delivered',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                                color: Colors.red,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "OrderId:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "#${ord[position].id}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Order Amount:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "₹${ord[position].totPrice}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Payment Type:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          (ord[position].payType == "1")
                                              ? "Offline"
                                              : "Online",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                                color: Colors.red,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    // Image.asset(
                                    //   'assets/Group 1998.png',
                                    //   scale: 1.2,
                                    // ),
                                    SvgPicture.asset(
                                        'assets/svg/Group 1998.svg'),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Work',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[800]),
                                        ),
                                        Text(
                                          "${ord[position].address}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              //fontWeight: FontWeight.w600,
                                              color: Colors.grey[800]),
                                        ),
                                        Text(
                                          "${ord[position].location}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              //fontWeight: FontWeight.w600,
                                              color: Colors.grey[800]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewScreen(
                                          widget.userId,
                                          ord[position].kitchenId),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red[700],
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      height:
                                          40, //MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
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
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 20, top: 20),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              kitchenLogo(ord[position].logo),
                              // Container(
                              //   height: 70,
                              //   width: 70,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     image: DecorationImage(
                              //       image: AssetImage('assets/grills.png'),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${ord[position].kitchenName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    // Text(
                                    //   'Lunch & Dinner Pack',
                                    //   style: TextStyle(
                                    //       fontSize: 14,
                                    //       color: Colors.black87,
                                    //       fontWeight: FontWeight.w500),
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 1,
                                    // ),
                                    Text(
                                      "₹${ord[position].totPrice}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // RichText(
                                    //   text: TextSpan(
                                    //     text:
                                    //         'Dal + Butter Roti + Butter Paneer Masala + Gulab Jamun + Pulao + Aloo Vada',
                                    //     style: TextStyle(
                                    //         fontSize: 8,
                                    //         color: Colors.black87,
                                    //         fontWeight: FontWeight.w300),
                                    //     children: <TextSpan>[
                                    //       TextSpan(
                                    //         text: ' MORE',
                                    //         style: TextStyle(
                                    //             fontSize: 7,
                                    //             color: Colors.red,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              (ord[position].status == "5")
                                  ? Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Material(
                                          elevation: 5,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.red[700],
                                          child: Container(
                                            height: 30,
                                            width: 70,
                                          ),
                                        ),
                                        Text(
                                          'Cancelled',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Material(
                                          elevation: 5,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.green[800],
                                          child: Container(
                                            height: 30,
                                            width: 70,
                                          ),
                                        ),
                                        Text(
                                          "Delivered",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                ),
              );
            },
          );
  }

  @override
  void initState() {
    getOrderHistoryListData(widget.userId).then((value) {
      for (int i = 0; i < value.length; i++) {
        setState(() {
          click.add(false);
        });
      }
    });
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        centerTitle: true,
        title: Text(
          'Order History',
          style: TextStyle(
              //color: Colors.grey[800],
              ),
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: FutureBuilder(
              future: getOrderHistoryListData(widget.userId),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? orderHistory(snapshot.data)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
