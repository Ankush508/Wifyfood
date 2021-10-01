import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenView/addmenuscreen.dart';
import 'package:wifyfood/KitchenView/addofferscreen.dart';
import 'package:wifyfood/KitchenView/addspecialitem.dart';
import 'package:wifyfood/KitchenView/helpscreen.dart';
import 'package:wifyfood/KitchenView/menuitemscreen.dart';
import 'package:wifyfood/KitchenView/myaccountscreen.dart';
import 'package:wifyfood/KitchenView/offersscreen.dart';
import 'package:wifyfood/KitchenView/settingsscreen.dart';
import 'package:share/share.dart';
import 'package:wifyfood/KitchenView/signinscreen.dart';
import 'package:wifyfood/UserView/selecttypescreen.dart';
import 'package:wifyfood/Language/text_keys.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  final String userId;
  final String kitchenName;
  final String email;
  final String logo;

  CollapsingNavigationDrawer(
      this.userId, this.kitchenName, this.email, this.logo);
  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState
    extends State<CollapsingNavigationDrawer> {
  bool clickMenu = false;
  bool clickOffer = false;

  Widget kitchenLogo(String logo) {
    print("Logo : $logo");
    logo = base64.normalize(logo);
    Uint8List bytes;
    setState(() {
      bytes = base64Decode(logo);
    });
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
      //child: Image.memory(bytes),
    );
  }

  bool showPic = false;
  @override
  void initState() {
    if (widget.logo == "" || widget.logo == null) {
      showPic = false;
    } else {
      showPic = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Stack(
        children: [
          BackgroundScreen(),
          Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: showPic
                    ? kitchenLogo(widget.logo)
                    : Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        //child: Image.memory(bytes),
                      ),
              ),
              SizedBox(height: 10),
              // Text(
              //   'Family Cook Off',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              Text(
                '${widget.kitchenName}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Text(
              //   'Info@cookoff.com',
              //   style: TextStyle(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              Text(
                '${widget.email}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  //addRepaintBoundaries: false,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (clickMenu == true) {
                            clickMenu = false;
                          } else {
                            clickMenu = true;
                          }
                        });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MyCampaignScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/menu.svg'),
                            SizedBox(width: 15.0),
                            Text(
                              Languages.of(context).menu,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            clickMenu
                                ? SvgPicture.asset('assets/svg/drop down.svg')
                                : SvgPicture.asset(
                                    'assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    clickMenu
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MenuItemScreen(widget.userId),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Row(
                                children: <Widget>[
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-9.png',
                                  // ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    Languages.of(context).disMenu,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Spacer(),
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-10.png',
                                  // )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    clickMenu
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddMenuScreen(
                                      widget.userId,
                                      widget.kitchenName,
                                      widget.email,
                                      widget.logo),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Row(
                                children: <Widget>[
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-9.png',
                                  // ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    Languages.of(context).addMenu,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Spacer(),
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-10.png',
                                  // )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    clickMenu
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddSpecialItemScreen(
                                      widget.userId,
                                      widget.kitchenName,
                                      widget.email,
                                      widget.logo),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Row(
                                children: <Widget>[
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-9.png',
                                  // ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    // Languages.of(context).addMenu,
                                    "Add Special Item",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Spacer(),
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-10.png',
                                  // )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (clickOffer == true) {
                            clickOffer = false;
                          } else {
                            clickOffer = true;
                          }
                        });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MyCampaignScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/gift.svg'),
                            SizedBox(width: 15.0),
                            Text(
                              Languages.of(context).offer,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            clickOffer
                                ? SvgPicture.asset('assets/svg/drop down.svg')
                                : SvgPicture.asset(
                                    'assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    clickOffer
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OffersScreen(widget.userId),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Row(
                                children: <Widget>[
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-9.png',
                                  // ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    Languages.of(context).disOffer,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Spacer(),
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-10.png',
                                  // )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    clickOffer
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddOfferScreen(widget.userId),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
                              child: Row(
                                children: <Widget>[
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-9.png',
                                  // ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    Languages.of(context).addOffer,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Spacer(),
                                  // Image.asset(
                                  //   'assets/Vector Smart Object-10.png',
                                  // )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => OffersScreen(),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.symmetric(
                    //         horizontal: 25.0, vertical: 10.0),
                    //     child: Row(
                    //       children: <Widget>[
                    //         SvgPicture.asset('assets/svg/gift.svg'),
                    //         SizedBox(width: 15.0),
                    //         Text(
                    //           'Offers',
                    //           style: TextStyle(
                    //             fontSize: 18.0,
                    //             fontWeight: FontWeight.w300,
                    //           ),
                    //         ),
                    //         Spacer(),
                    //         SvgPicture.asset('assets/svg/right drop down.svg'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyAccountScreen(widget.userId),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/user.svg'),
                            SizedBox(width: 15.0),
                            Text(
                              Languages.of(context).myAcc,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/settings.svg'),
                            SizedBox(width: 15.0),
                            Text(
                              Languages.of(context).sett,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MyCampaignScreen(),
                        //   ),
                        // );
                        Share.share("WifyFood App " +
                            "https://wifispc.com/images/mcdonalds-wi-fi-lg.jpg");
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/share.svg'),
                            SizedBox(width: 15.0),
                            Expanded(
                              child: Container(
                                child: Text(
                                  Languages.of(context).shareApp,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            //Spacer(),
                            SizedBox(width: 5),
                            SvgPicture.asset('assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MyCampaignScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/rate us.svg'),
                            SizedBox(width: 15.0),
                            Expanded(
                              child: Container(
                                //color: Colors.black12,
                                child: Text(
                                  Languages.of(context).rateUs,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            //Spacer(),
                            SizedBox(width: 5),
                            SvgPicture.asset('assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/help.svg'),
                            SizedBox(width: 15.0),
                            Text(
                              Languages.of(context).help,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        SetKitchenId().removeKitchenIdLocal();
                        SetKitchenId().removeKitchenMobLocal();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SelectTypeScreen(widget.userId),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MyCampaignScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset('assets/svg/logout.svg'),
                            SizedBox(width: 15.0),
                            Text(
                              Languages.of(context).signOut,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/right drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
