import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/order_received_filter.dart';
import 'package:wifyfood/KitchenView/kitchendashboard.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/KitchenHandlers/order_received.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class OrderReceivedScreen extends StatefulWidget {
  final String kid;
  OrderReceivedScreen(this.kid);
  @override
  _OrderReceivedScreenState createState() => _OrderReceivedScreenState();
}

class _OrderReceivedScreenState extends State<OrderReceivedScreen> {
  DateTime date;
  bool filter = false;
  Future<void> _selectDateOfBirth(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date ?? now,
      firstDate: DateTime(2010), //now,
      lastDate: now,
    );
    if (picked != null && picked != date) {
      print("dob: $picked");
      setState(() {
        date = picked;
        todayDate = DateFormat('yyyy/MM/dd').format(date);
        filter = true;
      });
    }
  }

  Widget orders(List<OrderReceived> order) {
    return (order.length == 0)
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
            itemCount: order.length,
            itemBuilder: (BuildContext context, int position) {
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 110,
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
                          //color: Colors.black12,
                          width: (MediaQuery.of(context).size.width - 20) * 0.2,
                          height: 100,
                          child: Center(
                            child: Container(
                              width: ((MediaQuery.of(context).size.width - 20) *
                                      0.2) *
                                  0.85,
                              height:
                                  ((MediaQuery.of(context).size.width - 20) *
                                          0.2) *
                                      0.85,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(245, 146, 33, 100),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Container(
                                  width: ((MediaQuery.of(context).size.width -
                                              20) *
                                          0.2) *
                                      0.7,
                                  height: ((MediaQuery.of(context).size.width -
                                              20) *
                                          0.2) *
                                      0.7,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(245, 146, 33, 1),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'BILL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${order[position].totalPrice}",
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
                          width: (MediaQuery.of(context).size.width - 20) * 0.6,
                          height: 100,
                          //color: Colors.black26,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Order Id: ${order[position].orderId}",
                                style: TextStyle(fontSize: 8),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${order[position].fullName} " +
                                    "${order[position].lastName}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    "Quantity: ${order[position].orderQuantity}",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(
                                    'assets/svg/clock.svg',
                                    width: 8,
                                  ),
                                  Text(
                                    "Time Remaining : ",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                  Text(
                                    "30min",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 22,
                                width:
                                    (MediaQuery.of(context).size.width - 20) *
                                        0.75,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: order[position].menu.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${order[position].menu[index].dishName}  " +
                                                      "x" +
                                                      "${order[position].menu[index].quantity}",
                                                  style: TextStyle(fontSize: 8),
                                                ),
                                                Text(
                                                  (order[position]
                                                              .menu[index]
                                                              .foodType ==
                                                          "0")
                                                      ? "Full"
                                                      : "Half",
                                                  style: TextStyle(
                                                      fontSize: 6,
                                                      color: Colors.red),
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
                        (order[position].orderStatus == "2")
                            ? Container(
                                //color: Colors.black12,
                                width:
                                    (MediaQuery.of(context).size.width - 20) *
                                        0.2,
                                height: 100,
                                child: Center(
                                    child: Text(
                                  "R",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )),
                              )
                            : Container(
                                //color: Colors.black12,
                                width:
                                    (MediaQuery.of(context).size.width - 20) *
                                        0.2,
                                height: 100,
                                child: Center(
                                    child: Text(
                                  "P",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                )),
                              ),
                        // Container(
                        //   //color: Colors.black12,
                        //   width: (MediaQuery.of(context).size.width - 20) * 0.2,
                        //   height: 100,
                        //   child: Center(
                        //     child: SvgPicture.asset(
                        //       'assets/svg/Group 2017.svg',
                        //       width: 25,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget ordersFilter(List<OrderReceivedFilter> order) {
    return (order.length == 0)
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
            itemCount: order.length,
            itemBuilder: (BuildContext context, int position) {
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 110,
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
                          //color: Colors.black12,
                          width: (MediaQuery.of(context).size.width - 20) * 0.2,
                          height: 100,
                          child: Center(
                            child: Container(
                              width: ((MediaQuery.of(context).size.width - 20) *
                                      0.2) *
                                  0.85,
                              height:
                                  ((MediaQuery.of(context).size.width - 20) *
                                          0.2) *
                                      0.85,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(245, 146, 33, 100),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Container(
                                  width: ((MediaQuery.of(context).size.width -
                                              20) *
                                          0.2) *
                                      0.7,
                                  height: ((MediaQuery.of(context).size.width -
                                              20) *
                                          0.2) *
                                      0.7,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(245, 146, 33, 1),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'BILL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${order[position].totalPrice}",
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
                          width: (MediaQuery.of(context).size.width - 20) * 0.6,
                          height: 100,
                          //color: Colors.black26,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Order Id: ${order[position].orderId}",
                                style: TextStyle(fontSize: 8),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${order[position].fullName} " +
                                    "${order[position].lastName}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    "Quantity: ${order[position].orderQuantity}",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(
                                    'assets/svg/clock.svg',
                                    width: 8,
                                  ),
                                  Text(
                                    "Time Remaining : ",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                  Text(
                                    "30min",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 22,
                                width:
                                    (MediaQuery.of(context).size.width - 20) *
                                        0.75,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: order[position].menu.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${order[position].menu[index].dishName}  " +
                                                      "x" +
                                                      "${order[position].menu[index].quantity}",
                                                  style: TextStyle(fontSize: 8),
                                                ),
                                                Text(
                                                  (order[position]
                                                              .menu[index]
                                                              .foodType ==
                                                          "0")
                                                      ? "Full"
                                                      : "Half",
                                                  style: TextStyle(
                                                      fontSize: 6,
                                                      color: Colors.red),
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
                        (order[position].orderStatus == "2")
                            ? Container(
                                //color: Colors.black12,
                                width:
                                    (MediaQuery.of(context).size.width - 20) *
                                        0.2,
                                height: 100,
                                child: Center(
                                    child: Text(
                                  "R",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )),
                              )
                            : Container(
                                //color: Colors.black12,
                                width:
                                    (MediaQuery.of(context).size.width - 20) *
                                        0.2,
                                height: 100,
                                child: Center(
                                    child: Text(
                                  "P",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                )),
                              ),
                        // Container(
                        //   //color: Colors.black12,
                        //   width: (MediaQuery.of(context).size.width - 20) * 0.2,
                        //   height: 100,
                        //   child: Center(
                        //     child: SvgPicture.asset(
                        //       'assets/svg/Group 2017.svg',
                        //       width: 25,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  String todayDate;
  DateTime now;

  @override
  void initState() {
    // PushNotification().initialize();
    // now = new DateTime.now();
    //todayDate = DateFormat('dd/MM/yyyy').format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KitchenDashboard(),
          ),
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            Languages.of(context).ord + " " + Languages.of(context).rec,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        body: Stack(
          children: [
            BackgroundScreen(),
            SafeArea(
                child: ListView(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        (filter == true) ? "$todayDate" : "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          await _selectDateOfBirth(context);
                        },
                        child: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                (filter == true)
                    ? FutureBuilder(
                        future: getOrderReceivedFilterListData(
                            widget.kid, todayDate),
                        builder: (context, snapshot) {
                          return snapshot.data != null
                              ? ordersFilter(snapshot.data)
                              : Container(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                        },
                      )
                    : FutureBuilder(
                        future: getOrderReceivedListData(widget.kid),
                        builder: (context, snapshot) {
                          return snapshot.data != null
                              ? orders(snapshot.data)
                              : Container(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                        },
                      ),
                SizedBox(height: 20),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
