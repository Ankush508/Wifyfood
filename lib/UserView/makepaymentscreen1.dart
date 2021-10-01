import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/cart.dart';
import 'package:wifyfood/UserView/orderconfirmscreen.dart';
import 'package:wifyfood/UserHandlers/card_list.dart';
import 'package:wifyfood/UserHandlers/order_place.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MakePaymentScreen extends StatefulWidget {
  final String userId,
      totalAmount,
      addressType,
      address,
      location,
      addressId,
      orderTotal,
      kitchenName,
      email,
      logo,
      kitchenId,
      totalQuantity,
      orderId;

  final List itemId;
  MakePaymentScreen(
      this.userId,
      this.totalAmount,
      this.addressType,
      this.address,
      this.location,
      this.addressId,
      this.orderTotal,
      this.itemId,
      this.kitchenName,
      this.email,
      this.logo,
      this.kitchenId,
      this.totalQuantity,
      this.orderId);
  @override
  _MakePaymentScreenState createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  bool isSelectPayTm = false;
  bool isSelectPhonePe = false;
  bool isSelectAmazonPay = false;
  // UpiIndia _upiIndia = UpiIndia();
  // UpiApp payPayTm = UpiApp.paytm;
  // UpiApp payPhonePe = UpiApp.phonePe;
  // UpiApp payAmazonPay = UpiApp.amazonPay;
  String response, payType = "Online";
  int _payMethod = 0;
  //PaymentMethod _paymentMethod;
  String error;

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    // PushNotification().initialize();
    // print("Id: $id");
    super.initState();
  }

  Widget cardList(List<Data> cardList) {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: cardList.length,
        itemBuilder: (context, position) {
          var card = cardList[position];
          return GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/Group 2000.svg'),
                        SizedBox(width: 5),
                        Text(
                          '${cardList[position].cardNo.substring(0, 4)}-XXXX-XXXX-${cardList[position].cardNo.substring(12, 16)}',
                          style: TextStyle(
                            fontSize: 16,
                            //color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      Languages.of(context).selectCard,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget kitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    setState(() {
      bytes = base64Decode(logo);
    });

    return Container(
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CartCount>();
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        kitchenLogo(widget.logo),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 122,
                              child: Text(
                                "${widget.kitchenName}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width - 122,
                              child: Text(
                                "${widget.email}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/Group 1998.svg'),
                        SizedBox(width: 20),
                        Container(
                          width: MediaQuery.of(context).size.width - 122,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.addressType}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  //  color: Colors.grey[800],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${widget.address}',
                                style: TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.w600,
                                  //  color: Colors.grey[800],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${widget.location}',
                                style: TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.w600,
                                  //  color: Colors.grey[800],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Select Payment Type",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            new Radio(
                              value: 0,
                              groupValue: this._payMethod,
                              onChanged: (int value) {
                                print("Payment Type (Online): $value");
                                setState(() {
                                  this._payMethod = value;
                                  // dep = "";
                                  // depName = "";
                                  // doj = "";
                                  // desg = "";
                                  // desName = "";
                                  payType = "Online";
                                });
                              },
                            ),
                            new Text(
                              'Online Payment/Card/UPI',
                              style: new TextStyle(color: Colors.grey[800]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            new Radio(
                              value: 1,
                              groupValue: this._payMethod,
                              onChanged: (int value) {
                                print("Payment Type (Offline): $value");
                                setState(() {
                                  this._payMethod = value;
                                  // dep = "";
                                  // depName = "";
                                  // doj = "";
                                  // desg = "";
                                  // desName = "";
                                  payType = "Offline";
                                });
                              },
                            ),
                            new Text(
                              'Pay Cash on Delivery',
                              style: new TextStyle(color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Text(
                    //   Languages.of(context).wallets,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     color: Colors.transparent,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             // SvgPicture.asset('assets/svg/Group 2001.svg'),
                    //             SizedBox(width: 10),
                    //             Image.asset(
                    //               'assets/paytm.png',
                    //               scale: 15,
                    //             ),
                    //             SizedBox(width: 10),
                    //             Text(
                    //               'PayTm',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 //color: Colors.grey[800],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Text(
                    //           Languages.of(context).pay,
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.red,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Divider(
                    //   thickness: 1,
                    // ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     color: Colors.transparent,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             // SvgPicture.asset('assets/svg/d5fvy0a9.svg'),
                    //             SizedBox(width: 10),
                    //             Image.asset(
                    //               'assets/phonpay.png',
                    //               scale: 15,
                    //             ),
                    //             SizedBox(width: 10),
                    //             Text(
                    //               'PhonePe',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 //color: Colors.grey[800],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Text(
                    //           Languages.of(context).pay,
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.red,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Divider(
                    //   thickness: 1,
                    // ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     color: Colors.transparent,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             // SvgPicture.asset('assets/svg/my5nmrgb.svg'),
                    //             SizedBox(width: 10),
                    //             Image.asset(
                    //               'assets/amazon pay.png',
                    //               scale: 15,
                    //             ),
                    //             SizedBox(width: 10),
                    //             Text(
                    //               'AmazonPay',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 //color: Colors.grey[800],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Text(
                    //           Languages.of(context).pay,
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.red,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 30),
                    // Text(
                    //   Languages.of(context).cards,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // FutureBuilder(
                    //   future: getCardListData(widget.userId),
                    //   builder: (context, snapshot) {
                    //     return snapshot.data != null
                    //         ? cardList(snapshot.data)
                    //         : Center(
                    //             child: CircularProgressIndicator(),
                    //           );
                    //   },
                    // ),
                    // SizedBox(height: 20),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //             AddNewCardScreen(widget.userId),
                    //       ),
                    //     );
                    //   },
                    //   child: Material(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Colors.transparent,
                    //     //color: Colors.green[800],
                    //     child: Container(
                    //       height: 40, //MediaQuery.of(context).size.height,
                    //       width: MediaQuery.of(context).size.width * 0.4,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.red),
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.transparent,
                    //       ),
                    //       child: Center(
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             SvgPicture.asset(
                    //                 'assets/svg/Icon feather-credit-card.svg'),
                    //             Text(
                    //               Languages.of(context).addNewCard,
                    //               style: TextStyle(
                    //                 color: Colors.red,
                    //                 fontWeight: FontWeight.w600,
                    //                 fontSize: 12,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 30),
                    // Text(
                    //   Languages.of(context).payOnDel,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // Row(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           payType = "Offline";
                    //         });
                    //         // Fluttertoast.showToast(
                    //         //   msg: "Selected Cash on Delivery",
                    //         //   fontSize: 20,
                    //         //   textColor: Colors.white,
                    //         //   backgroundColor: Colors.blue,
                    //         //   toastLength: Toast.LENGTH_LONG,
                    //         // );
                    //       },
                    //       child: Container(
                    //         height: 40, //MediaQuery.of(context).size.height,
                    //         width: MediaQuery.of(context).size.width * 0.5,
                    //         decoration: BoxDecoration(
                    //           border: Border.all(color: Colors.red),
                    //           borderRadius: BorderRadius.circular(10),
                    //           color: Colors.transparent,
                    //         ),
                    //         child: Center(
                    //           child: Text(
                    //             Languages.of(context).cod,
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               //color: Colors.grey[800],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 10),
                    //     (payType == "Offline")
                    //         ? SvgPicture.asset(
                    //             'assets/svg/Group 2017.svg',
                    //             height: 20,
                    //           )
                    //         : Container(),
                    //   ],
                    // ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        if (payType == "") {
                          Fluttertoast.showToast(
                            msg: "Select Payment Mode First",
                            fontSize: 20,
                            textColor: Colors.white,
                            backgroundColor: Colors.blue,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        } else if (payType == "Offline") {
                          getOrderPlaceData(
                                  widget.userId,
                                  widget.kitchenId,
                                  widget.addressId,
                                  widget.totalQuantity,
                                  widget.orderTotal,
                                  "0",
                                  "0",
                                  payType,
                                  widget.itemId)
                              .then((value) {
                            //print(widget.itemId);
                            if (value.status == 1) {
                              getCart(widget.userId).then((value) {
                                print("Cart Count: ${value.cart.length}");
                                c.upCartCount(value.cart.length.toString());
                                // updateCartCount(value.cart.length.toString());
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderConfirmScreen(
                                      widget.userId,
                                      widget.addressType,
                                      widget.address,
                                      widget.location),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Try Again",
                                fontSize: 20,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          });
                        } else if (payType == "Online") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentWebView(
                                  widget.totalAmount,
                                  widget.addressType,
                                  widget.address,
                                  widget.location,
                                  widget.addressId,
                                  widget.totalAmount,
                                  widget.itemId,
                                  widget.kitchenName,
                                  widget.email,
                                  widget.logo,
                                  widget.kitchenId,
                                  widget.totalQuantity,
                                  widget.orderId,
                                  widget.orderTotal,
                                  widget.userId,
                                  payType),
                            ),
                          );
                        }
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[800],
                        child: Container(
                          height: 50, //MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              (payType == "Offline")
                                  ? "Continue"
                                  : Languages.of(context).payNow,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PaymentWebView extends StatefulWidget {
  final String totalAmount,
      addressType,
      address,
      location,
      addressId,
      orderTotal,
      kitchenName,
      email,
      logo,
      kitchenId,
      totalQuantity,
      orderId,
      amount,
      userId,
      payType;
  final List itemId;
  PaymentWebView(
      this.totalAmount,
      this.addressType,
      this.address,
      this.location,
      this.addressId,
      this.orderTotal,
      this.itemId,
      this.kitchenName,
      this.email,
      this.logo,
      this.kitchenId,
      this.totalQuantity,
      this.orderId,
      this.amount,
      this.userId,
      this.payType);
  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  var id = new DateTime.now().millisecondsSinceEpoch;
  void initState() {
    super.initState();
    print("Order Id: $id");
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CartCount>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Payment',
          style: TextStyle(
            //color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl:
                'https://wifyfood.com/ccavenue/data/${widget.totalAmount}/${widget.userId}',
            // initialUrl:
            //     'https://wifyfood.com/ccavenue/data/${widget.orderId}/${widget.amount}/${widget.userId}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageFinished: (String url) {
              if (url == "https://wifyfood.com/payment_handler/") {
                getOrderPlaceData(
                        widget.userId,
                        widget.kitchenId,
                        widget.addressId,
                        widget.totalQuantity,
                        widget.orderTotal,
                        "0",
                        "0",
                        widget.payType,
                        widget.itemId)
                    .then((value) {
                  //print(widget.itemId);
                  if (value.status == 1) {
                    getCart(widget.userId).then((value) {
                      print("Cart Count: ${value.cart.length}");
                      c.upCartCount(value.cart.length.toString());
                      // updateCartCount(value.cart.length.toString());
                    });
                    Fluttertoast.showToast(
                      msg: "Payment Successful",
                      fontSize: 20,
                      textColor: Colors.white,
                      backgroundColor: Colors.blue,
                      toastLength: Toast.LENGTH_LONG,
                    );
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmScreen(
                            widget.userId,
                            widget.addressType,
                            widget.address,
                            widget.location),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Try Again",
                      fontSize: 20,
                      textColor: Colors.white,
                      backgroundColor: Colors.blue,
                      toastLength: Toast.LENGTH_LONG,
                    );
                  }
                });
              }
              print('Page finished loading: $url');
            },
          );
        },
      ),
    );
  }
}
