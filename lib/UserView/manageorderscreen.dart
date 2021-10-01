import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Helper/get_current_location.dart';
import 'package:wifyfood/UserHandlers/manage_order.dart';
import 'package:wifyfood/UserHandlers/order_cancel.dart';
import 'package:wifyfood/UserHandlers/track_order.dart';
import 'package:wifyfood/UserView/trackorderscreen1.dart';

class ManageOrderScreen extends StatefulWidget {
  final String userId;
  ManageOrderScreen(this.userId);
  @override
  _ManageOrderScreenState createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
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
      ),
    );
  }

  Widget manageOrder(List<Order> ord) {
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
              return Container(
                color: (position.isEven) ? Colors.transparent : Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          kitchenLogo(ord[position].logo),
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
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  getTrackOrderKitListData(ord[position].id)
                                      .then((value1) {
                                    if (value1[0].lat != null ||
                                        value1[0].long != null) {
                                      CurrentLocation()
                                          .getCurrentLatLong()
                                          .then((value) {
                                        // userLocation = LocationData.fromMap({
                                        //   "latitude": value.latitude,
                                        //   "longitude": value.longitude,
                                        // });
                                        try {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TrackOrderScreen(
                                                      widget.userId,
                                                      ord[position].kitchenId,
                                                      ord[position].id,
                                                      LocationData.fromMap({
                                                        "latitude":
                                                            value.latitude,
                                                        "longitude":
                                                            value.longitude,
                                                      }),
                                                      LocationData.fromMap({
                                                        "latitude":
                                                            double.parse(
                                                                value1[0].lat),
                                                        "longitude":
                                                            double.parse(
                                                                value1[0].long),
                                                        // "latitude": var1.latitude,
                                                        // "longitude": var1.longitude,
                                                      })),
                                            ),
                                          );
                                        } catch (e) {
                                          print(e);
                                        }
                                      });
                                    } else {
                                      print("Not Okay");
                                    }
                                  });
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green[800],
                                      child: Container(
                                        height: 30,
                                        width: 90,
                                      ),
                                    ),
                                    Text(
                                      "Track Order",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Container(
                                            padding: const EdgeInsets.all(30),
                                            height: 200,
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Cancel Order?"),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        //color: Colors.amber,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          height: 40,
                                                          width: 100,
                                                          child: Center(
                                                            child: Text(
                                                              "Close",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        // getRemoveAddress(
                                                        //         userId,
                                                        //         addressData[
                                                        //                 position]
                                                        //             .id)
                                                        //     .then((value) {
                                                        //   setState(() {});
                                                        // });
                                                        getOrderCancelData(
                                                                ord[position]
                                                                    .id)
                                                            .then((value) {
                                                          setState(() {});
                                                        });
                                                      },
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.red,
                                                        child: Container(
                                                          height: 40,
                                                          width: 100,
                                                          child: Center(
                                                            child: Text(
                                                              "Cancel Order",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red[800],
                                      child: Container(
                                        height: 30,
                                        width: 90,
                                      ),
                                    ),
                                    Text(
                                      "Cancel Order",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
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
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          // Image.asset(
                          //   'assets/Group 1998.png',
                          //   scale: 1.2,
                          // ),
                          SvgPicture.asset('assets/svg/Group 1998.svg'),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
              );
            });
  }

  @override
  void initState() {
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
          'Manage Orders',
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
              future: getManageOrderListData(widget.userId),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? manageOrder(snapshot.data)
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
