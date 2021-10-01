import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/add_item.dart';
import 'package:wifyfood/UserHandlers/address_list.dart';
import 'package:wifyfood/UserHandlers/apply_coupon.dart';
import 'package:wifyfood/UserHandlers/cart.dart';
import 'package:wifyfood/UserHandlers/remove_item.dart';
import 'package:wifyfood/UserView/addnewaddressscreencart.dart';
import 'package:wifyfood/UserView/billdetailsscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  final String userId;
  CartScreen(this.userId);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  String addressType;
  String address;
  String location;
  String addressId;
  String kitchenId;
  String totalQuantity;
  String kitchenName;
  String logo;
  String email;
  String orderId;
  double itemTotal = 0.0;
  var itemPrice = "0";
  double totalDiscount = 0.0;
  double deliveryCharge = 0.0;
  double cartTotal = 0.0;
  double package = 0.0;
  double gst = 0.0;
  double baseCharge = 0.0;
  double distanceCharge = 0.0;
  String couponCode = "";
  TextEditingController _coupon = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  bool isAddressSelect = false, isClickApply = false;
  String selectAddressId = "";
  //List<Cart> emptyCart;
  List<String> itemId = [];
  List<Cart> cartList = [];
  List<int> cartListOrderQuantity = [];
  List<int> cartListOrderPrice = [];

  Widget cartView(List<Cart> cartData, String userId) {
    final c = context.watch<CartCount>();
    print("Cart Length: ${cartList.length}");
    return (cartList.length == 0)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Text(
                Languages.of(context).emptyCart,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        : ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: cartData.length + 1,
            itemBuilder: (context, position) {
              return (position == cartData.length)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !isClickApply
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isClickApply = true;
                                    });
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: Colors.white,
                                    elevation: 10,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      width: MediaQuery.of(context)
                                          .size
                                          .width, //120,
                                      height: 50,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/discount.svg'),
                                            const SizedBox(width: 5),
                                            Text(
                                              Languages.of(context).coupon,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Form(
                                  key: _formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: Colors.white,
                                    elevation: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      width: MediaQuery.of(context)
                                          .size
                                          .width, //120,
                                      height: 130,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/svg/discount.svg'),
                                              const SizedBox(width: 5),
                                              Text(
                                                Languages.of(context).coupon,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // SizedBox(height: 20),
                                                  Container(
                                                    // color: Colors.black26,
                                                    height: 70,
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Colors.lightBlue[50],

                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  _coupon,
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                    .isEmpty) {
                                                                  return "Enter Coupon Code";
                                                                }
                                                                return null;
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Enter Coupon',
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  couponCode =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            isClickApply =
                                                                false;
                                                            _coupon.text = "";
                                                          });
                                                        },
                                                        child: Container(
                                                          child: Text(
                                                            // (discount == 0)
                                                            //     ?
                                                            "Cancel",
                                                            //     :
                                                            // "Remove",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          // (couponCode == "")
                                                          //     ? Fluttertoast.showToast(
                                                          //         msg:
                                                          //             "Enter Coupon Code",
                                                          //         backgroundColor:
                                                          //             Colors.blueGrey[
                                                          //                 800],
                                                          //         toastLength: Toast
                                                          //             .LENGTH_LONG,
                                                          //         gravity:
                                                          //             ToastGravity
                                                          //                 .CENTER,
                                                          //         timeInSecForIosWeb:
                                                          //             3)
                                                          //     :
                                                          postApplyCoupon(
                                                                  couponCode,
                                                                  widget.userId)
                                                              .then((value) {
                                                            if (value.status ==
                                                                1) {
                                                              setState(() {
                                                                isClickApply =
                                                                    false;
                                                              });
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Coupon Applied",
                                                                fontSize: 20,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                              );
                                                              setState(() {
                                                                // itemTotal = itemTotal -
                                                                //     double.parse(
                                                                //         value
                                                                //             .couponValue);
                                                                totalDiscount =
                                                                    double.parse(
                                                                        value
                                                                            .couponValue);
                                                                cartTotal = cartTotal -
                                                                    double.parse(
                                                                        value
                                                                            .couponValue);
                                                                _coupon.text =
                                                                    couponCode;
                                                              });
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Invalid Coupon",
                                                                fontSize: 20,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                              );
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          child: Text(
                                                            "Apply",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700],
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 30),
                          Text(
                            Languages.of(context).detail,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages.of(context).total,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '₹${double.parse(itemTotal.toStringAsFixed(2))}',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                //SizedBox(width: 10),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages.of(context).discount,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '₹${double.parse(totalDiscount.toStringAsFixed(2))}',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                //SizedBox(width: 10),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10.0, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            elevation: 0,
                                            child: Container(
                                              height: 235,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Delivery Charges",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 0),
                                                    child: Text(
                                                      "Delivery Charge helps compensate your delivery valet fairly for fulfilling your order",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Base charge",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          '₹${double.parse(baseCharge.toStringAsFixed(2))}',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        //SizedBox(width: 10),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Distance charge",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          '₹${double.parse(distanceCharge.toStringAsFixed(2))}',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        //SizedBox(width: 10),
                                                      ],
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets
                                                  //           .symmetric(
                                                  //       horizontal: 10,
                                                  //       vertical: 0),
                                                  //   child: Row(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment
                                                  //             .spaceBetween,
                                                  //     children: [
                                                  //       Text(
                                                  //         "Discount on delivery charge",
                                                  //         style: TextStyle(
                                                  //           fontSize: 16,
                                                  //         ),
                                                  //       ),
                                                  //       Text(
                                                  //         '-₹10',
                                                  //         style: TextStyle(
                                                  //           color: Colors.red,
                                                  //         ),
                                                  //       ),
                                                  //       //SizedBox(width: 10),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Divider(
                                                      thickness: 1,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Total",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          '₹${double.parse((baseCharge + distanceCharge).toStringAsFixed(2))}',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        //SizedBox(width: 10),
                                                      ],
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(7),
                                                            child: Text(
                                                              "Close",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        //SizedBox(width: 10),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    Languages.of(context).delivery,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                // Text(
                                //   '₹${double.parse(deliveryCharge.toStringAsFixed(2))}',
                                //   style: TextStyle(
                                //     color: Colors.red,
                                //   ),
                                // ),
                                //SizedBox(width: 10),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          InkWell(
                            onTap: () {
                              print("Clicked");
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      elevation: 0,
                                      child: Container(
                                        height: 210,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Taxes and Charges",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   '₹$totalDiscount',
                                                  //   style: TextStyle(
                                                  //     color: Colors.red,
                                                  //   ),
                                                  // ),
                                                  //SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Kitchen Packaging",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹${double.parse(package.toStringAsFixed(2))}',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  //SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Kitchen Tax",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹${double.parse(gst.toStringAsFixed(2))}',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  //SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.black45,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Total",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹${double.parse((package + gst).toStringAsFixed(2))}',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  //SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7),
                                                      child: Text(
                                                        "Close",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  //SizedBox(width: 10),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 10.0, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Taxes and Charges",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  // Text(
                                  //   '₹$deliveryCharge',
                                  //   style: TextStyle(
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                  //SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                          // const Divider(
                          //   thickness: 1,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, right: 10.0, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages.of(context).toPay,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹${double.parse(cartTotal.toStringAsFixed(2))}',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                //SizedBox(width: 10),
                              ],
                            ),
                          ),
                          isAddressSelect
                              ? SizedBox(height: 20)
                              : SizedBox(height: 0),
                          isAddressSelect
                              ? Text(
                                  Languages.of(context).delTo,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Container(),
                          isAddressSelect
                              ? SizedBox(height: 20)
                              : SizedBox(height: 0),
                          isAddressSelect
                              ? Row(
                                  children: [
                                    (addressType == "Work")
                                        ? SvgPicture.asset(
                                            'assets/svg/Group 1998.svg')
                                        : SvgPicture.asset(
                                            'assets/svg/Group 1997.svg'),
                                    SizedBox(width: 20),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$addressType',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[800]),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '$address',
                                            style: TextStyle(
                                                fontSize: 12,
                                                //fontWeight: FontWeight.w600,
                                                color: Colors.grey[800]),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '$location',
                                            style: TextStyle(
                                                fontSize: 12,
                                                //fontWeight: FontWeight.w600,
                                                color: Colors.grey[800]),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cartList[position].dishName}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                cartList[position].foodType == "1"
                                    ? Languages.of(context).half
                                    : Languages.of(context).full,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                getRemoveData(
                                                        widget.userId,
                                                        cartData[position]
                                                            .cartid)
                                                    .then((value) {
                                                  setState(() {});
                                                  getCart(widget.userId)
                                                      .then((value) {
                                                    setState(() {
                                                      isLoading = false;
                                                      itemTotal = double.parse(
                                                          value.orderPrice);
                                                      totalDiscount =
                                                          double.parse(value
                                                              .orderDiscount);
                                                      deliveryCharge =
                                                          double.parse(value
                                                              .deliveryCharge
                                                              .toString());
                                                      // cartTotal = double.parse(
                                                      //     value.cartTotal
                                                      //         .toString());
                                                      cartTotal = double.parse(
                                                              value.cartTotal
                                                                  .toString()) +
                                                          double.parse(value
                                                              .deliveryCharge
                                                              .toString()) +
                                                          double.parse(value
                                                              .taxCharge
                                                              .toString()) +
                                                          double.parse(value
                                                              .packCharge
                                                              .toString());
                                                      print(
                                                          "Cart Count: ${value.cart.length}");
                                                      c.upCartCount(value
                                                          .cart.length
                                                          .toString());
                                                    });

                                                    // setState(() {});
                                                  });
                                                });
                                                // setState(() {
                                                //   if (cartListOrderQuantity[
                                                //           position] >
                                                //       1) {
                                                //     cartListOrderQuantity[
                                                //         position]--;
                                                //     cartListOrderPrice[
                                                //             position] =
                                                //         cartListOrderPrice[
                                                //                 position] -
                                                //             int.parse(cartList[
                                                //                     position]
                                                //                 .fullPrice);
                                                //     itemTotal = itemTotal -
                                                //         int.parse(
                                                //             cartList[position]
                                                //                 .fullPrice);
                                                //     cartTotal = cartTotal -
                                                //         int.parse(
                                                //             cartList[position]
                                                //                 .fullPrice);
                                                //     getRemoveData(
                                                //             widget.userId,
                                                //             cartList[position]
                                                //                 .cartid)
                                                //         .then((value) {
                                                //       print("Item Removed");
                                                //       try {
                                                //         initState();
                                                //       } catch (e) {
                                                //         print(e);
                                                //       }
                                                //     });
                                                //   } else if (cartListOrderQuantity[
                                                //           position] ==
                                                //       1) {
                                                //     getRemoveData(
                                                //             widget.userId,
                                                //             cartList[position]
                                                //                 .cartid)
                                                //         .then((value) {
                                                //       print("Item Removed");
                                                //       getCart(widget.userId)
                                                //           .then((value) {
                                                //         print(
                                                //             "Cart Count: ${value.cart.length}");
                                                //         c.upCartCount(value
                                                //             .cart.length
                                                //             .toString());
                                                //       });
                                                //       try {
                                                //         initState();
                                                //       } catch (e) {
                                                //         print(e);
                                                //       }
                                                //     });
                                                //   }
                                                // });
                                              },
                                              child: Container(
                                                //color: Colors.black26,
                                                child: Center(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            // '${cartListOrderQuantity[position]}',
                                            "${cartData[position].orderQuantity}",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                getAddItemData(
                                                        widget.userId,
                                                        cartList[position].id,
                                                        cartList[position]
                                                            .fullPrice,
                                                        cartList[position]
                                                            .foodType,
                                                        kitchenId)
                                                    .then((value) {
                                                  setState(() {
                                                    getCart(widget.userId)
                                                        .then((value) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      itemTotal = double.parse(
                                                          value.orderPrice);
                                                      totalDiscount =
                                                          double.parse(value
                                                              .orderDiscount);
                                                      deliveryCharge =
                                                          double.parse(value
                                                              .deliveryCharge
                                                              .toString());
                                                      // cartTotal = double.parse(
                                                      //     value.cartTotal
                                                      //         .toString());
                                                      cartTotal = double.parse(
                                                              value.cartTotal
                                                                  .toString()) +
                                                          double.parse(value
                                                              .deliveryCharge
                                                              .toString()) +
                                                          double.parse(value
                                                              .taxCharge
                                                              .toString()) +
                                                          double.parse(value
                                                              .packCharge
                                                              .toString());

                                                      // print(
                                                      //     "Cart Count: ${value.cart.length}");
                                                      // c.upCartCount(value
                                                      //     .cart.length
                                                      //     .toString());
                                                    });
                                                  });
                                                });
                                                // setState(() {
                                                //   //isLoading = true;
                                                //   setState(() {
                                                //     cartListOrderQuantity[
                                                //         position]++;
                                                //     cartListOrderPrice[
                                                //             position] =
                                                //         cartListOrderPrice[
                                                //                 position] +
                                                //             int.parse(cartList[
                                                //                     position]
                                                //                 .fullPrice);
                                                //     itemTotal = itemTotal +
                                                //         int.parse(
                                                //             cartList[position]
                                                //                 .fullPrice);
                                                //     cartTotal = cartTotal +
                                                //         int.parse(
                                                //             cartList[position]
                                                //                 .fullPrice);
                                                //     getAddItemData(
                                                //             userId,
                                                //             cartList[position]
                                                //                 .id,
                                                //             cartList[position]
                                                //                 .fullPrice,
                                                //             cartList[position]
                                                //                 .foodType,
                                                //             kitchenId)
                                                //         .then((value) {
                                                //       isLoading = false;
                                                //       try {
                                                //         initState();
                                                //       } catch (e) {
                                                //         print(e);
                                                //       }
                                                //     });
                                                //   });
                                                // });
                                              },
                                              child: Container(
                                                //color: Colors.black38,
                                                child: Center(
                                                  child: Text(
                                                    '+',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: 40,
                                child: Text(
                                  // '₹${cartListOrderPrice[position]}',
                                  "${cartData[position].orderPrice}",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
            },
          );
  }

  Widget listViewWidget(
      List<Data> addressData, String userId, BuildContext context) {
    return addressData.length == 0
        ? Center(
            child: Text('No Address Available'),
          )
        : ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: addressData.length,
            itemBuilder: (context, position) {
              return GestureDetector(
                onTap: () async {
                  setState(() {
                    isAddressSelect = true;
                    addressType = addressData[position].addressType;
                    address = addressData[position].address;
                    location = addressData[position].location;
                    addressId = addressData[position].id;
                  });
                  Fluttertoast.showToast(
                    msg: "Address Selected",
                    fontSize: 20,
                    textColor: Colors.white,
                    backgroundColor: Colors.blue,
                    toastLength: Toast.LENGTH_LONG,
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(left: 5),
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/Group 1998.svg'),
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${addressData[position].addressType}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${addressData[position].address}',
                              style: TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${addressData[position].location}',
                              style: TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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

  var pic;
  bool showPic = false;

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

  // void getCartDetail(){}

  @override
  void initState() {
    super.initState();
    getCart(widget.userId).then((value) {
      print("Cart Length: ${value.cart.length}");
      setState(() {
        itemTotal = double.parse(value.orderPrice);
        totalDiscount = double.parse(value.orderDiscount);
        deliveryCharge = double.parse(value.deliveryCharge.toString());
        package = double.parse(value.packCharge.toString());
        gst = double.parse(value.taxCharge.toString());
        baseCharge = double.parse(value.baseDelCharge.toString());
        distanceCharge = double.parse(value.distanceCharge.toString());
        kitchenName = value.kitchenName;
        logo = value.logo;
        email = value.email;
        kitchenId = value.kitchenId;
        totalQuantity = value.totalQuantity;
        cartTotal = double.parse(value.cartTotal.toString()) +
            double.parse(value.deliveryCharge.toString()) +
            double.parse(value.taxCharge.toString()) +
            double.parse(value.packCharge.toString());
        for (int i = 0; i < value.cart.length; i++) {
          itemId.add(value.cart[i].id);
        }

        showPic = true;
      });
      pic = kitchenLogo(logo);
      //print("$itemId");
    });
    getCartData(widget.userId).then((value) {
      setState(() {
        cartList = value;
        for (int i = 0; i < cartList.length; i++) {
          cartListOrderQuantity.add(int.parse(cartList[i].orderQuantity));
          cartListOrderPrice.add(int.parse(cartList[i].orderPrice));
        }
      });
      //kitchenId = value[0].kitchenId;
    });
    getAddressList(widget.userId);
    // PushNotification().initialize();
  }

  // void addItem(){

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundScreen(),
          SafeArea(
            child: Container(
              child: ListView(
                children: [
                  (cartList.isEmpty)
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Text(
                                      '$kitchenName',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Text(
                                      '$email',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              showPic ? pic : Container(),
                            ],
                          ),
                        ),
                  const SizedBox(height: 0),
                  FutureBuilder(
                    future: getCartData(widget.userId),
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? cartView(snapshot.data, widget.userId)
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black12,
                  // child: Center(
                  //   child: CircularProgressIndicator(),
                  // ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: (cartList.isEmpty)
          ? Container(
              height: 0,
            )
          : Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        //barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                              builder: (context, StateSetter setState) {
                            return Dialog(
                              child: Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //shrinkWrap: true,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          left: 10,
                                          bottom: 10,
                                        ),
                                        child: Text(
                                            Languages.of(context).chooseAdd,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            )
                                            //color: Colors.grey[700]),
                                            ),
                                      ),
                                      FutureBuilder(
                                        future:
                                            getAddressListData(widget.userId),
                                        builder: (context, snapshot) {
                                          return snapshot.data != null
                                              ? listViewWidget(snapshot.data,
                                                  widget.userId, context)
                                              : Container(
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNewAddressScreen(
                                                      widget.userId),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 20, top: 10),
                                          child: Center(
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.green[800],
                                              child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Center(
                                                  child: Text(
                                                    '+ ' +
                                                        Languages.of(context)
                                                            .addNewAdd,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.amber,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: Text(
                              Languages.of(context).selectAdd,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isAddressSelect == true) {
                        setState(() {
                          isAddressSelect = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillDetailsScreen(
                                widget.userId,
                                cartTotal.toString(),
                                totalDiscount.toString(),
                                addressType,
                                address,
                                location,
                                addressId,
                                itemId,
                                kitchenName,
                                email,
                                logo,
                                kitchenId,
                                totalQuantity,
                                double.parse(baseCharge.toString()),
                                double.parse(distanceCharge.toString()),
                                double.parse(package.toString()),
                                double.parse(gst.toString()),
                                "1"),
                          ),
                        );
                      } else if (isAddressSelect == false) {
                        Fluttertoast.showToast(
                          msg: "Select Address First",
                          fontSize: 20,
                          textColor: Colors.white,
                          backgroundColor: Colors.blue,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[800],
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: Text(
                              Languages.of(context).proceed,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
