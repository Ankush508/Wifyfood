import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/UserView/makepaymentscreen1.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/cart.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class BillDetailsScreen extends StatefulWidget {
  final String userId,
      totalAmount,
      totalDiscount,
      addressType,
      address,
      location,
      addressId,
      kitchenName,
      email,
      logo,
      kitchenId,
      totalQuantity,
      orderId;
  final double baseCharge, distanceCharge, package, gst;

  // final String totalAmount;
  // final String addressType;
  // final String address;
  // final String location;
  // final String addressId;
  final List itemId;
  BillDetailsScreen(
      this.userId,
      this.totalAmount,
      this.totalDiscount,
      this.addressType,
      this.address,
      this.location,
      this.addressId,
      this.itemId,
      this.kitchenName,
      this.email,
      this.logo,
      this.kitchenId,
      this.totalQuantity,
      this.baseCharge,
      this.distanceCharge,
      this.package,
      this.gst,
      this.orderId);
  @override
  _BillDetailsScreenState createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  var itemTotal = "0";
  // var itemPrice = "0";
  // var totalDiscount = "0";
  var deliveryCharge = "0";
  // var cartTotal = "0";
  // bool isAddressSelect = false;
  // String selectAddressId = "";
  // List<Cart> emptyCart;
  List<Cart> cartList;

  Widget cartView(List<Cart> cartData, String userId) {
    return (cartList.length == 0)
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Text(
                      "Cart is Empty",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.white,
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width, //120,
                    height: 50,
                    child: Center(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/discount.svg'),
                          const SizedBox(width: 5),
                          Text(
                            'Apply Coupon',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Bill Detail',
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
                        'Item Total',
                        style: TextStyle(
                          fontSize: 16,
                          //color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        '$itemTotal',
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
                        'Total Discount',
                        style: TextStyle(
                          fontSize: 16,
                          //color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        '- ${widget.totalDiscount}',
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
                  padding:
                      const EdgeInsets.only(top: 10, right: 10.0, bottom: 10),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Delivery Charges",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          child: Text(
                                            "Delivery Charge helps compensate your delivery valet fairly for fulfilling your order",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Base charge",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '₹${double.parse(widget.baseCharge.toStringAsFixed(2))}',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              //SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Distance charge",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '₹${double.parse(widget.distanceCharge.toStringAsFixed(2))}',
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '₹${double.parse((widget.baseCharge + widget.distanceCharge).toStringAsFixed(2))}',
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 12),
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
                                                      const EdgeInsets.all(7),
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
                // const Divider(
                //   thickness: 1,
                // ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Taxes and Charges",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Kitchen Packaging",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '₹${double.parse(widget.package.toStringAsFixed(2))}',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        //SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Kitchen GST",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '₹${double.parse(widget.gst.toStringAsFixed(2))}',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        //SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '₹${double.parse((widget.package + widget.gst).toStringAsFixed(2))}',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: const EdgeInsets.all(7),
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
                    padding:
                        const EdgeInsets.only(top: 10, right: 10.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, right: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To Pay',
                        style: TextStyle(
                            fontSize: 16,
                            //color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.totalAmount}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      //SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
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
                                    //color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '₹$itemTotal',
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
                                    //color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '₹${widget.totalDiscount}',
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
                                                          '₹${double.parse(widget.baseCharge.toStringAsFixed(2))}',
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
                                                          '₹${double.parse(widget.distanceCharge.toStringAsFixed(2))}',
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
                                                          '₹${double.parse((widget.baseCharge + widget.distanceCharge).toStringAsFixed(2))}',
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
                                                    '₹${double.parse(widget.package.toStringAsFixed(2))}',
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
                                                    '₹${double.parse(widget.gst.toStringAsFixed(2))}',
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
                                                    '₹${double.parse((widget.package + widget.gst).toStringAsFixed(2))}',
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10.0, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages.of(context).toPay,
                                  style: TextStyle(
                                      fontSize: 16,
                                      //color: Colors.grey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹${widget.totalAmount}',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                //SizedBox(width: 10),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            Languages.of(context).delTo,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              (widget.addressType == "Work")
                                  ? SvgPicture.asset(
                                      'assets/svg/Group 1998.svg')
                                  : SvgPicture.asset(
                                      'assets/svg/Group 1997.svg'),
                              SizedBox(width: 20),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.addressType}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800]),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${widget.address}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey[800]),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${widget.location}',
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
                          ),
                          SizedBox(height: 10),
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
                                  //fontSize: 16,
                                  //fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      '${cartList[position].orderQuantity}',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: 40,
                                child: Text(
                                  '₹${cartData[position].orderPrice}',
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
    );
  }

  @override
  void initState() {
    getCart(widget.userId).then((value) {
      setState(() {
        itemTotal = value.orderPrice;
        // totalDiscount = value.orderDiscount;
        deliveryCharge = value.deliveryCharge;
        // cartTotal = value.cartTotal.toString();
      });
    });
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   iconTheme: IconThemeData(color: Colors.grey[800]),
      // ),
      body: Stack(
        children: [
          const BackgroundScreen(),
          SafeArea(
            child: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 120,
                              child: Text(
                                "${widget.kitchenName}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width - 120,
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
                        kitchenLogo(widget.logo),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0),
                  FutureBuilder(
                    future: getCartData(widget.userId),
                    builder: (context, snapshot) {
                      cartList = snapshot.data;
                      return snapshot.data != null
                          ? cartView(cartList, widget.userId)
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                //color: Colors.amber,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹${widget.totalAmount}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        Languages.of(context).incAllCharges,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          //color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakePaymentScreen(
                        widget.userId,
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
                        widget.orderId),
                  ),
                );
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
                        Languages.of(context).makePay,
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
