import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/menu_detail.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class MenuDetailsScreen extends StatefulWidget {
  final String itemId;
  MenuDetailsScreen(this.itemId);
  @override
  _MenuDetailsScreenState createState() => _MenuDetailsScreenState();
}

class _MenuDetailsScreenState extends State<MenuDetailsScreen> {
  String itemName = " ";
  String itemPrice = " ";
  String itemDescription = " ";
  String maxQuantity = " ";
  String itemPhoto = "";
  bool isLoading = true;

  Widget menuItemPhoto(String photo) {
    photo = base64.normalize(photo);

    // switch (photo.length % 4) {
    //   case 1:
    //     break; // this case can't be handled well, because 3 padding chars is illeagal.
    //   case 2:
    //     photo = photo + "==";
    //     break;
    //   case 3:
    //     photo = photo + "=";
    //     break;
    // }
    Uint8List bytes;
    bytes = base64Decode(photo);
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
      // child: Center(
      //   child: SvgPicture.asset('assets/svg/Icon feather-image.svg'),
      // ),
    );
  }

  @override
  void initState() {
    getMenuDetail(widget.itemId).then((value) {
      setState(() {
        itemName = value.menuDetail.dishName;
        itemPrice = value.menuDetail.price;
        itemDescription = value.menuDetail.description;
        maxQuantity = value.menuDetail.maxQuantity;
        itemPhoto = value.menuDetail.photo;
        isLoading = false;
      });
    });
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).menuItems,
          style: TextStyle(
              //color: Colors.grey[700],
              ),
        ),
        actions: [
          //SvgPicture.asset('assets/svg/Group 2019.svg'),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
          SafeArea(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //   child: Image.asset('assets/aa1kx9no.png'),
                          // ),
                          menuItemPhoto(itemPhoto),
                          SizedBox(height: 30),
                          Text(
                            '$itemName',
                            style: TextStyle(
                                fontSize: 26,
                                //color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '₹' + '$itemPrice',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '$itemDescription',
                            style: TextStyle(
                                fontSize: 16,
                                //color: Colors.black87,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 30),
                          Text(
                            Languages.of(context).maxQuan,
                            style: TextStyle(
                                fontSize: 20,
                                //color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '$maxQuantity',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(height: 30),
                          // Text(
                          //   Languages.of(context).images,
                          //   style: TextStyle(
                          //       fontSize: 20,
                          //       //color: Colors.black87,
                          //       fontWeight: FontWeight.w500),
                          // ),
                          // SizedBox(height: 15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Image.asset(
                          //       'assets/Rounded Rectangle -22.png',
                          //       scale: 1.1,
                          //     ),
                          //     Image.asset(
                          //       'assets/Rounded Rectangle -24.png',
                          //       scale: 1.1,
                          //     ),
                          //     Image.asset(
                          //       'assets/Rounded Rectangle -23.png',
                          //       scale: 1.1,
                          //     ),
                          //     Image.asset(
                          //       'assets/Rounded Rectangle -25.png',
                          //       scale: 1.1,
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
