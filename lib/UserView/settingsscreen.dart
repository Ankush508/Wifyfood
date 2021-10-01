import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserView/aboutwifyfoodscreen.dart';
import 'package:wifyfood/UserView/manageaddressscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserView/myaccountscreen.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class SettingsScreen extends StatefulWidget {
  final String userId, cityId;
  final List<String> address;
  SettingsScreen(this.userId, this.address, this.cityId);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).setting,
          style: TextStyle(
              //color: Colors.grey[700],
              ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Center(
                      child: SvgPicture.asset('assets/svg/Group 2013.svg'),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutWifyFoodScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, bottom: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Languages.of(context).aboutInfo,
                              style: TextStyle(
                                fontSize: 16,
                                //color: Colors.grey[800],
                              ),
                            ),
                            // Image.asset('assets/Icon ionic-ios-arrow-back.png')
                          ],
                        ),
                      ),
                    ),
                    // Divider(
                    //   color: Colors.red,
                    //   //thickness: 1.5,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => AppSettingsScreen(),
                    //       ),
                    //     );
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //         left: 30, right: 30, bottom: 20, top: 20),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           'App Settings',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             color: Colors.grey[800],
                    //           ),
                    //         ),
                    //         // Image.asset('assets/Icon ionic-ios-arrow-back.png')
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Divider(
                      color: Colors.red,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ManageAddressScreen(widget.userId),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, bottom: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Languages.of(context).manAdd,
                              style: TextStyle(
                                fontSize: 16,
                                //color: Colors.grey[800],
                              ),
                            ),
                            // Image.asset('assets/Icon ionic-ios-arrow-back.png')
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyAccountScreen(
                                widget.userId, widget.address, widget.cityId),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, bottom: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Languages.of(context).accSetting,
                              style: TextStyle(
                                fontSize: 16,
                                //color: Colors.grey[800],
                              ),
                            ),
                            // Image.asset('assets/Icon ionic-ios-arrow-back.png')
                          ],
                        ),
                      ),
                    ),
                    // Divider(
                    //   color: Colors.red,
                    //   //thickness: 1.5,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       left: 30, right: 30, bottom: 20, top: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Night Mode',
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           color: Colors.grey[800],
                    //         ),
                    //       ),
                    //       // Stack(
                    //       //   alignment: AlignmentDirectional.center,
                    //       //   children: [
                    //       //     Image.asset('assets/Rectangle 138.png'),
                    //       //     Row(
                    //       //       mainAxisAlignment:
                    //       //           MainAxisAlignment.spaceBetween,
                    //       //       children: [
                    //       //         Image.asset('assets/OFF.png'),
                    //       //         SizedBox(width: 10),
                    //       //         Image.asset('assets/Rectangle 139.png'),
                    //       //       ],
                    //       //     )
                    //       //   ],
                    //       // )
                    //       GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             _isNightMode = !_isNightMode;
                    //             if (_isNightMode == true) {
                    //               themeChange.darkTheme = _isNightMode;
                    //             } else if (_isNightMode == false) {
                    //               themeChange.darkTheme = _isNightMode;
                    //             }
                    //           });
                    //         },
                    //         child: Container(
                    //           width: 60,
                    //           height: 25,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(50),
                    //             color: Colors.grey[300],
                    //           ),
                    //           child: _isNightMode
                    //               ? Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 5),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Text(
                    //                         "ON",
                    //                         style:
                    //                             TextStyle(color: Colors.grey),
                    //                       ),
                    //                       Container(
                    //                         width: 20,
                    //                         height: 20,
                    //                         decoration: BoxDecoration(
                    //                           borderRadius:
                    //                               BorderRadius.circular(50),
                    //                           color: Colors.grey[500],
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 )
                    //               : Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 5),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Container(
                    //                         width: 20,
                    //                         height: 20,
                    //                         decoration: BoxDecoration(
                    //                           borderRadius:
                    //                               BorderRadius.circular(50),
                    //                           color: Colors.grey[500],
                    //                         ),
                    //                       ),
                    //                       Text(
                    //                         "OFF",
                    //                         style:
                    //                             TextStyle(color: Colors.grey),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Divider(
                      color: Colors.red,
                      //thickness: 1.5,
                    ),
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
