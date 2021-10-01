// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:wifyfood/Helper/custom_widgets.dart';
// import 'package:wifyfood/UserView/addnewcardscreen.dart';
// import 'package:wifyfood/UserView/orderconfirmscreen.dart';
// import 'package:upi_india/upi_india.dart';
// import 'package:flutter_upi/flutter_upi.dart';
// // import 'package:stripe_payment/stripe_payment.dart';
// import 'package:wifyfood/UserHandlers/card_list.dart';
// import 'package:wifyfood/UserHandlers/order_place.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:typed_data';
// // import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
// import 'package:wifyfood/Language/text_keys.dart';
// import 'package:razorpay_plugin/razorpay_plugin.dart';

// class StripeTransactionResponse {
//   String message;
//   bool success;
//   StripeTransactionResponse({this.message, this.success});
// }

// class StripeService {
//   static String apiBase = "https://api.stripe.com/v1";
//   static String paymentApiUrl = "${StripeService.apiBase}/payment_intents";
//   static String secret =
//       "sk_test_51IL8IqIQqZSSjr0pRgZiZOQAAaIA3443jzLdpRdh78vP8ku76uNu23DuUuvjYNQATat364dvhomw7tBTivBKYLQy00O80BJufd";
//   static Map<String, String> headers = {
//     'Authorization': "Bearer ${StripeService.secret}",
//     'Content-Type': "application/x-www-form-urlencoded",
//   };

//   static init() {
//     StripePayment.setOptions(StripeOptions(
//       publishableKey:
//           "pk_test_51IL8IqIQqZSSjr0pKfWEOpS5Vkuz98aqoxJEweRrLm5oyVe99nYewhX9OP9IQMR2bWZRFuThVaCh6cIrRldVGufs009ovHSSeN",
//       merchantId: "Test",
//       androidPayMode: "test",
//     ));
//   }

//   static Future<StripeTransactionResponse> payViaExistingCard(
//       String amount, CreditCard card) async {
//     try {
//       var paymentMethod = await StripePayment.createPaymentMethod(
//         PaymentMethodRequest(card: card),
//       );
//       var paymentIntent = await StripeService.createPaymentIntent(amount);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//         clientSecret: paymentIntent['client_secret'],
//         paymentMethodId: paymentMethod.id,
//       ));
//       if (response.status == 'succeeded') {
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (err) {
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (e) {
//       return new StripeTransactionResponse(
//           message: 'Transaction failed: ${e.toString()}', success: false);
//     }
//   }

//   static getPlatformExceptionErrorResult(err) {
//     String message = 'Something went wrong';
//     if (err.code == 'cancelled') {
//       message = 'Transaction cancelled';
//     }

//     return new StripeTransactionResponse(message: message, success: false);
//   }

//   static Future<Map<String, dynamic>> createPaymentIntent(String amount) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount + "00",
//         'currency': "INR",
//         'payment_method_types[]': 'card',
//       };
//       var response = await http.post(
//         StripeService.paymentApiUrl,
//         body: body,
//         headers: StripeService.headers,
//       );
//       return jsonDecode(response.body);
//     } catch (e) {
//       print("err charing user: ${e.toString()}");
//     }
//     return null;
//   }
// }

// class MakePaymentScreen extends StatefulWidget {
//   final String userId,
//       totalAmount,
//       addressType,
//       address,
//       location,
//       addressId,
//       orderTotal,
//       kitchenName,
//       email,
//       logo,
//       kitchenId,
//       totalQuantity;
//   // final String totalAmount;
//   // final String addressType;
//   // final String address;
//   // final String location;
//   // final String addressId;
//   // final String orderTotal;
//   final List itemId;
//   MakePaymentScreen(
//       this.userId,
//       this.totalAmount,
//       this.addressType,
//       this.address,
//       this.location,
//       this.addressId,
//       this.orderTotal,
//       this.itemId,
//       this.kitchenName,
//       this.email,
//       this.logo,
//       this.kitchenId,
//       this.totalQuantity);
//   @override
//   _MakePaymentScreenState createState() => _MakePaymentScreenState();
// }

// class _MakePaymentScreenState extends State<MakePaymentScreen> {
//   bool isSelectPayTm = false;
//   bool isSelectPhonePe = false;
//   bool isSelectAmazonPay = false;
//   UpiIndia _upiIndia = UpiIndia();
//   UpiApp payPayTm = UpiApp.paytm;
//   UpiApp payPhonePe = UpiApp.phonePe;
//   UpiApp payAmazonPay = UpiApp.amazonPay;
//   String response, payType = "";
//   //PaymentMethod _paymentMethod;
//   String error;

//   // SharedPreferences prefs = await SharedPreferences.getInstance();
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//   Future<String> startUpiTransaction(String app, String payAmount) async {
//     return response = await FlutterUpi.initiateTransaction(
//       app: app,
//       pa: "8437145619@ybl",
//       pn: "Ankush Kumar",
//       tr: "TestingId",
//       tn: "Not actual. Testing Transaction",
//       am: payAmount,
//       mc: "YourMerchantId", // optional
//       cu: "INR",
//       url: "https://www.google.com",
//     );
//   }

//   Future<UpiResponse> initiateTransaction(UpiApp app, double payAmount) async {
//     return _upiIndia.startTransaction(
//       app: app, //  I took only the first app from List<UpiApp> app.
//       receiverUpiId: '8437145619@ybl', // Make Sure to change this UPI Id
//       receiverName: 'Ankush Kumar',
//       transactionRefId: 'TestingId',
//       transactionNote: 'Not actual. Testing Transaction',
//       amount: payAmount,
//     );
//   }

//   void setError(dynamic error) {
//     _scaffoldKey.currentState
//         // ignore: deprecated_member_use
//         .showSnackBar(SnackBar(content: Text(error.toString())));
//     setState(() {
//       error = error.toString();
//     });
//   }

//   Future paymentViaExistingCard(BuildContext context, Data card) async {
//     // showProgressDialog(context: context, loadingText: "Please Wait...");

// //dismissProgressDialog();

//     CreditCard stripeCard = CreditCard(
//       number: card.cardNo,
//       expMonth: int.parse(card.validThrough.substring(0, 2)),
//       expYear: int.parse(card.validThrough.substring(5, 7)),
//     );
//     var response =
//         await StripeService.payViaExistingCard(widget.totalAmount, stripeCard);
//     // dismissProgressDialog();
//     if (response.success == true) {
//       // ignore: deprecated_member_use
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text(response.message),
//         duration: new Duration(milliseconds: 1200),
//       ));
//     } else {
//       // ignore: deprecated_member_use
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text(response.message),
//         duration: new Duration(milliseconds: 1200),
//       ));
//     }
//     return response;
//   }

//   @override
//   void initState() {
//     StripeService.init();
//     super.initState();
//   }

//   Widget cardList(List<Data> cardList) {
//     return ListView.builder(
//         physics: ScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: cardList.length,
//         itemBuilder: (context, position) {
//           var card = cardList[position];
//           return GestureDetector(
//             onTap: () {
//               // print("Month: ${card.validThrough.substring(0, 2)}");
//               // print("Year: ${card.validThrough.substring(5, 7)}");
//               // final CreditCard testCard = CreditCard(
//               //   number: '${cardList[position].cardNo}',
//               //   expMonth:
//               //       int.parse(cardList[position].validThrough.substring(0, 2)),
//               //   expYear:
//               //       int.parse(cardList[position].validThrough.substring(3, 6)),
//               //   cvc: cardList[position].cvv,
//               // );
//               // StripePayment.createPaymentMethod(
//               //   PaymentMethodRequest(
//               //     card: testCard,
//               //   ),
//               // ).then((paymentMethod) {
//               //   _scaffoldKey.currentState.showSnackBar(
//               //       SnackBar(content: Text('Received ${paymentMethod.id}')));
//               //   setState(() {
//               //     _paymentMethod = paymentMethod;
//               //   });
//               // }).catchError(setError);
//               paymentViaExistingCard(context, card).then((value) {
//                 setState(() {
//                   payType = "Online";
//                 });
//                 if (value.success == true) {
//                   getOrderPlaceData(
//                           widget.userId,
//                           widget.kitchenId,
//                           widget.addressId,
//                           " ",
//                           widget.orderTotal,
//                           " ",
//                           " ",
//                           payType,
//                           widget.itemId)
//                       .then((value) {
//                     print(widget.itemId);
//                     if (value.status == 1) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OrderConfirmScreen(
//                               widget.userId,
//                               widget.addressType,
//                               widget.address,
//                               widget.location),
//                         ),
//                       );
//                     } else {
//                       Fluttertoast.showToast(
//                         msg: "Try Again",
//                         fontSize: 20,
//                         textColor: Colors.white,
//                         backgroundColor: Colors.blue,
//                         toastLength: Toast.LENGTH_LONG,
//                       );
//                     }
//                   });
//                 }
//               });
//             },
//             child: Container(
//               color: Colors.transparent,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         SvgPicture.asset('assets/svg/Group 2000.svg'),
//                         SizedBox(width: 5),
//                         Text(
//                           '${cardList[position].cardNo.substring(0, 4)}-XXXX-XXXX-${cardList[position].cardNo.substring(12, 16)}',
//                           style: TextStyle(
//                             fontSize: 16,
//                             //color: Colors.grey[800],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       Languages.of(context).selectCard,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   Widget kitchenLogo(String logo) {
//     logo = base64.normalize(logo);
//     Uint8List bytes;
//     setState(() {
//       bytes = base64Decode(logo);
//     });

//     return Container(
//       height: 80,
//       width: 80,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         image: DecorationImage(
//           image: MemoryImage(bytes),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           BackgroundScreen(),
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: const EdgeInsets.only(left: 30, right: 30),
//                 padding: const EdgeInsets.symmetric(vertical: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         kitchenLogo(widget.logo),
//                         SizedBox(width: 0),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width - 140,
//                               child: Text(
//                                 "${widget.kitchenName}",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Container(
//                               width: MediaQuery.of(context).size.width - 140,
//                               child: Text(
//                                 "${widget.email}",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         SvgPicture.asset('assets/svg/Group 1998.svg'),
//                         SizedBox(width: 20),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${widget.addressType}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 //  color: Colors.grey[800],
//                               ),
//                             ),
//                             Text(
//                               '${widget.address}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 //fontWeight: FontWeight.w600,
//                                 //  color: Colors.grey[800],
//                               ),
//                             ),
//                             Text(
//                               '${widget.location}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 //fontWeight: FontWeight.w600,
//                                 //  color: Colors.grey[800],
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 30),
//                     Text(
//                       Languages.of(context).wallets,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         // initiateTransaction(
//                         //         payPayTm, double.parse(widget.totalAmount))
//                         //     .then((value) {
//                         //   if (value.status == UpiPaymentStatus.SUCCESS) {
//                         //     Fluttertoast.showToast(
//                         //       msg: "Payment Success",
//                         //       fontSize: 20,
//                         //       textColor: Colors.white,
//                         //       backgroundColor: Colors.blue,
//                         //       toastLength: Toast.LENGTH_LONG,
//                         //     );
//                         //   } else if (value.status == UpiPaymentStatus.FAILURE) {
//                         //     Fluttertoast.showToast(
//                         //       msg: "Payment Failed",
//                         //       fontSize: 20,
//                         //       textColor: Colors.white,
//                         //       backgroundColor: Colors.blue,
//                         //       toastLength: Toast.LENGTH_LONG,
//                         //     );
//                         //   } else if (value.status ==
//                         //       UpiPaymentStatus.SUBMITTED) {
//                         //     ScaffoldMessenger.of(context).showSnackBar(
//                         //       const SnackBar(
//                         //         content: Text('Payment Pending...'),
//                         //         duration: Duration(seconds: 10),
//                         //       ),
//                         //     );
//                         //   }
//                         // });
//                         startUpiTransaction(
//                                 FlutterUpiApps.PayTM, widget.totalAmount)
//                             .then((value) {
//                           print(value);
//                           FlutterUpiResponse flutterUpiResponse =
//                               FlutterUpiResponse(response);
//                           if (flutterUpiResponse.Status == "SUCCESS") {
//                             Fluttertoast.showToast(
//                               msg: "Payment Success",
//                               fontSize: 20,
//                               textColor: Colors.white,
//                               backgroundColor: Colors.blue,
//                               toastLength: Toast.LENGTH_LONG,
//                             );
//                           } else if (flutterUpiResponse.Status == "FAILURE") {
//                             Fluttertoast.showToast(
//                               msg: "Payment Failed",
//                               fontSize: 20,
//                               textColor: Colors.white,
//                               backgroundColor: Colors.blue,
//                               toastLength: Toast.LENGTH_LONG,
//                             );
//                           } else if (flutterUpiResponse.Status == "SUBMITTED") {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Payment Pending...'),
//                                 duration: Duration(seconds: 10),
//                               ),
//                             );
//                           }
//                         });
//                       },
//                       child: Container(
//                         color: Colors.transparent,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 // SvgPicture.asset('assets/svg/Group 2001.svg'),
//                                 Image.asset('assets/Group 2001.png'),
//                                 Text(
//                                   'PayTm',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     //color: Colors.grey[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               Languages.of(context).pay,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // initiateTransaction(
//                         //         payPhonePe, double.parse(widget.totalAmount))
//                         //     .then((value) {
//                         //   if (value.status == UpiPaymentStatus.SUCCESS) {
//                         //     Fluttertoast.showToast(
//                         //       msg: "Payment Success",
//                         //       fontSize: 20,
//                         //       textColor: Colors.white,
//                         //       backgroundColor: Colors.blue,
//                         //       toastLength: Toast.LENGTH_LONG,
//                         //     );
//                         //   } else if (value.status == UpiPaymentStatus.FAILURE) {
//                         //     Fluttertoast.showToast(
//                         //       msg: "Payment Failed",
//                         //       fontSize: 20,
//                         //       textColor: Colors.white,
//                         //       backgroundColor: Colors.blue,
//                         //       toastLength: Toast.LENGTH_LONG,
//                         //     );
//                         //   } else if (value.status ==
//                         //       UpiPaymentStatus.SUBMITTED) {
//                         //     ScaffoldMessenger.of(context).showSnackBar(
//                         //       const SnackBar(
//                         //         content: Text('Payment Pending...'),
//                         //         duration: Duration(seconds: 10),
//                         //       ),
//                         //     );
//                         //   }
//                         // });
//                         startUpiTransaction(
//                                 FlutterUpiApps.PhonePe, widget.totalAmount)
//                             .then((value) {
//                           print(value);
//                           FlutterUpiResponse flutterUpiResponse =
//                               FlutterUpiResponse(response);
//                           if (flutterUpiResponse.Status == "SUCCESS") {
//                             Fluttertoast.showToast(
//                               msg: "Payment Success",
//                               fontSize: 20,
//                               textColor: Colors.white,
//                               backgroundColor: Colors.blue,
//                               toastLength: Toast.LENGTH_LONG,
//                             );
//                           } else if (flutterUpiResponse.Status == "FAILURE") {
//                             Fluttertoast.showToast(
//                               msg: "Payment Failed",
//                               fontSize: 20,
//                               textColor: Colors.white,
//                               backgroundColor: Colors.blue,
//                               toastLength: Toast.LENGTH_LONG,
//                             );
//                           } else if (flutterUpiResponse.Status == "SUBMITTED") {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Payment Pending...'),
//                                 duration: Duration(seconds: 10),
//                               ),
//                             );
//                           }
//                         });
//                       },
//                       child: Container(
//                         color: Colors.transparent,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 // SvgPicture.asset('assets/svg/d5fvy0a9.svg'),
//                                 Image.asset('assets/d5fvy0a9.png'),
//                                 Text(
//                                   'PhonePe',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     //color: Colors.grey[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               Languages.of(context).pay,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Divider(
//                       thickness: 1,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // initiateTransaction(
//                         //         payAmazonPay, double.parse(widget.totalAmount))
//                         //     .then((value) {
//                         //   if (value.status == UpiPaymentStatus.SUCCESS) {
//                         //     Fluttertoast.showToast(
//                         //       msg: "Payment Success",
//                         //       fontSize: 20,
//                         //       textColor: Colors.white,
//                         //       backgroundColor: Colors.blue,
//                         //       toastLength: Toast.LENGTH_LONG,
//                         //     );
//                         //   } else if (value.status == UpiPaymentStatus.FAILURE) {
//                         //     Fluttertoast.showToast(
//                         //       msg: "Payment Failed",
//                         //       fontSize: 20,
//                         //       textColor: Colors.white,
//                         //       backgroundColor: Colors.blue,
//                         //       toastLength: Toast.LENGTH_LONG,
//                         //     );
//                         //   } else if (value.status ==
//                         //       UpiPaymentStatus.SUBMITTED) {
//                         //     ScaffoldMessenger.of(context).showSnackBar(
//                         //       const SnackBar(
//                         //         content: Text('Payment Pending...'),
//                         //         duration: Duration(seconds: 10),
//                         //       ),
//                         //     );
//                         //   }
//                         // });
//                         startUpiTransaction(
//                                 FlutterUpiApps.AmazonPay, widget.totalAmount)
//                             .then((value) {
//                           print(value);
//                           FlutterUpiResponse flutterUpiResponse =
//                               FlutterUpiResponse(response);
//                           if (flutterUpiResponse.Status == "SUCCESS") {
//                             Fluttertoast.showToast(
//                               msg: "Payment Success",
//                               fontSize: 20,
//                               textColor: Colors.white,
//                               backgroundColor: Colors.blue,
//                               toastLength: Toast.LENGTH_LONG,
//                             );
//                           } else if (flutterUpiResponse.Status == "FAILURE") {
//                             Fluttertoast.showToast(
//                               msg: "Payment Failed",
//                               fontSize: 20,
//                               textColor: Colors.white,
//                               backgroundColor: Colors.blue,
//                               toastLength: Toast.LENGTH_LONG,
//                             );
//                           } else if (flutterUpiResponse.Status == "SUBMITTED") {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Payment Pending...'),
//                                 duration: Duration(seconds: 10),
//                               ),
//                             );
//                           }
//                         });
//                       },
//                       child: Container(
//                         color: Colors.transparent,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 // SvgPicture.asset('assets/svg/my5nmrgb.svg'),
//                                 Image.asset('assets/my5nmrgb.png'),
//                                 Text(
//                                   'AmazonPay',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     //color: Colors.grey[800],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               Languages.of(context).pay,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     Text(
//                       Languages.of(context).cards,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     FutureBuilder(
//                       future: getCardListData(widget.userId),
//                       builder: (context, snapshot) {
//                         return snapshot.data != null
//                             ? cardList(snapshot.data)
//                             : Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 AddNewCardScreen(widget.userId),
//                           ),
//                         );
//                       },
//                       child: Material(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.transparent,
//                         //color: Colors.green[800],
//                         child: Container(
//                           height: 40, //MediaQuery.of(context).size.height,
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.red),
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.transparent,
//                           ),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 SvgPicture.asset(
//                                     'assets/svg/Icon feather-credit-card.svg'),
//                                 Text(
//                                   Languages.of(context).addNewCard,
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     Text(
//                       Languages.of(context).payOnDel,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           payType = "Offline";
//                         });
//                         Fluttertoast.showToast(
//                           msg: "Selected Cash on Delivery",
//                           fontSize: 20,
//                           textColor: Colors.white,
//                           backgroundColor: Colors.blue,
//                           toastLength: Toast.LENGTH_LONG,
//                         );
//                       },
//                       child: Container(
//                         height: 40, //MediaQuery.of(context).size.height,
//                         width: MediaQuery.of(context).size.width * 0.5,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.red),
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.transparent,
//                         ),
//                         child: Center(
//                           child: Text(
//                             Languages.of(context).cod,
//                             style: TextStyle(
//                               fontSize: 14,
//                               //color: Colors.grey[800],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     GestureDetector(
//                       onTap: () {
//                         if (payType == "") {
//                           Fluttertoast.showToast(
//                             msg: "Select Payment Mode First",
//                             fontSize: 20,
//                             textColor: Colors.white,
//                             backgroundColor: Colors.blue,
//                             toastLength: Toast.LENGTH_LONG,
//                           );
//                         } else {
//                           getOrderPlaceData(
//                                   widget.userId,
//                                   widget.kitchenId,
//                                   widget.addressId,
//                                   widget.totalQuantity,
//                                   widget.orderTotal,
//                                   " ",
//                                   " ",
//                                   payType,
//                                   widget.itemId)
//                               .then((value) {
//                             //print(widget.itemId);
//                             if (value.status == 1) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => OrderConfirmScreen(
//                                       widget.userId,
//                                       widget.addressType,
//                                       widget.address,
//                                       widget.location),
//                                 ),
//                               );
//                             } else {
//                               Fluttertoast.showToast(
//                                 msg: "Try Again",
//                                 fontSize: 20,
//                                 textColor: Colors.white,
//                                 backgroundColor: Colors.blue,
//                                 toastLength: Toast.LENGTH_LONG,
//                               );
//                             }
//                           });
//                         }
//                       },
//                       child: Material(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.green[800],
//                         child: Container(
//                           height: 50, //MediaQuery.of(context).size.height,
//                           width: MediaQuery.of(context).size.width,
//                           child: Center(
//                             child: Text(
//                               Languages.of(context).payNow,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
