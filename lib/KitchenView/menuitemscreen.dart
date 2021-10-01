import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/menu_list.dart';
import 'package:wifyfood/KitchenView/menudetailscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';

class MenuItemScreen extends StatefulWidget {
  final String userId;
  MenuItemScreen(this.userId);
  @override
  _MenuItemScreenState createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  bool click1 = true;
  bool click2 = false;

  Widget menuItemPhoto(String photo) {
    photo = base64.normalize(photo);
    Uint8List bytes;
    bytes = base64Decode(photo);
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

// Regular menu list
  Widget menuListView(List<MenuList> menuListData, String userId) {
    return (menuListData.length == 0)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Text(
                Languages.of(context).emptyList,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: menuListData.length,
            itemBuilder: (context, position) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MenuDetailsScreen(menuListData[position].id),
                      ),
                    );
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          menuItemPhoto(menuListData[position].photo),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${menuListData[position].dishName}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      //color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  '₹${menuListData[position].price}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${menuListData[position].description}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w300),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  ' MORE',
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                // RichText(
                                //   text: TextSpan(
                                //     text:
                                //         '${menuListData[position].description}',
                                //     style: TextStyle(
                                //         fontSize: 10,
                                //         color: Colors.grey[800],
                                //         fontWeight: FontWeight.w300),
                                //     children: <TextSpan>[
                                //       TextSpan(
                                //         text: ' MORE',
                                //         style: TextStyle(
                                //             fontSize: 9,
                                //             color: Colors.red,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //     ],
                                //   ),
                                //   maxLines: 2,
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          SvgPicture.asset(
                              'assets/svg/menu items drop down.svg'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  // Special menu list
  Widget specialMenuListView(
      List<SpecialMenuList> menuListData, String userId) {
    return (menuListData.length == 0)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Text(
                Languages.of(context).emptyList,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: menuListData.length,
            itemBuilder: (context, position) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MenuDetailsScreen(menuListData[position].id),
                      ),
                    );
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          menuItemPhoto(menuListData[position].photo),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${menuListData[position].dishName}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      //color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  '₹${menuListData[position].price}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${menuListData[position].description}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w300),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  ' MORE',
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                // RichText(
                                //   text: TextSpan(
                                //     text:
                                //         '${menuListData[position].description}',
                                //     style: TextStyle(
                                //         fontSize: 10,
                                //         color: Colors.grey[800],
                                //         fontWeight: FontWeight.w300),
                                //     children: <TextSpan>[
                                //       TextSpan(
                                //         text: ' MORE',
                                //         style: TextStyle(
                                //             fontSize: 9,
                                //             color: Colors.red,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //     ],
                                //   ),
                                //   maxLines: 2,
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          SvgPicture.asset(
                              'assets/svg/menu items drop down.svg'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  @override
  void initState() {
    // getMenuList(widget.userId);
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).menuItems,
          style: TextStyle(),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
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
                          },
                          child: Container(
                            height: 50,
                            width: (MediaQuery.of(context).size.width - 30) / 2,
                            child: click1
                                ? Container(
                                    height: 50,
                                    width: (MediaQuery.of(context).size.width -
                                            30) /
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
                                    width: (MediaQuery.of(context).size.width -
                                            30) /
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
                                    width: (MediaQuery.of(context).size.width -
                                            30) /
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
                                    width: (MediaQuery.of(context).size.width -
                                            30) /
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
                  SizedBox(height: 20),
                  click2
                      ? FutureBuilder(
                          future: getSpecialMenuListData(widget.userId),
                          builder: (context, snapshot) {
                            return snapshot.data != null
                                ? specialMenuListView(
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
                          future: getMenuListData(widget.userId),
                          builder: (context, snapshot) {
                            return snapshot.data != null
                                ? menuListView(snapshot.data, widget.userId)
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
          ),
        ],
      ),
    );
  }
}
