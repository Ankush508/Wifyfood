import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenView/aboutinfoscreen.dart';
import 'package:wifyfood/UserView/selectlanguagescreen.dart';
import 'package:wifyfood/main.dart';
import 'package:wifyfood/Language/text_keys.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNightMode = false;
  @override
  void initState() {
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    setState(() {
      _isNightMode = themeChange.darkTheme;
    });
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
                      child: SvgPicture.asset('assets/svg/red settings.svg'),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutInfoScreen(),
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
                            SvgPicture.asset('assets/svg/red drop down.svg'),
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
                            builder: (context) => SelectLanguageScreen(),
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
                              Languages.of(context).entry7,
                              style: TextStyle(
                                fontSize: 16,
                                //color: Colors.grey[800],
                              ),
                            ),
                            SvgPicture.asset('assets/svg/red drop down.svg'),
                          ],
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => AccountSettingsScreen(),
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
                    //             //color: Colors.grey[800],
                    //           ),
                    //         ),
                    //         SvgPicture.asset('assets/svg/red drop down.svg'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Divider(
                      color: Colors.red,
                      //thickness: 1.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, bottom: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Languages.of(context).nightMode,
                            style: TextStyle(
                              fontSize: 16,
                              //color: Colors.grey[800],
                            ),
                          ),
                          // Stack(
                          //   alignment: AlignmentDirectional.center,
                          //   children: [
                          //     Image.asset('assets/Rectangle 138.png'),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Image.asset('assets/OFF.png'),
                          //         SizedBox(width: 10),
                          //         Image.asset('assets/Rectangle 139.png'),
                          //       ],
                          //     )
                          //   ],
                          // ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isNightMode = !_isNightMode;
                                if (_isNightMode == true) {
                                  themeChange.darkTheme = _isNightMode;
                                } else if (_isNightMode == false) {
                                  themeChange.darkTheme = _isNightMode;
                                }
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[300],
                              ),
                              child: _isNightMode
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Languages.of(context).oN,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.grey[500],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          Text(
                                            Languages.of(context).off,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
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
