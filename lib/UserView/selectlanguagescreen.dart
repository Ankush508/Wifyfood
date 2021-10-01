import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Language/locale_constant.dart';
import 'package:wifyfood/Language/text_keys.dart';

class SelectLanguageScreen extends StatefulWidget {
  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  bool isSelectEng = true,
      isSelectHin = false,
      isSelectGuj = false,
      isSelectBn = false,
      isSelectAr = false,
      isSelectTa = false,
      isSelectMl = false;

  @override
  void initState() {
    getLocale().then((value) {
      if (value == Locale('en')) {
        setState(() {
          isSelectEng = true;
          isSelectHin = false;
          isSelectGuj = false;
          isSelectBn = false;
          isSelectAr = false;
          isSelectTa = false;
          isSelectMl = false;
        });
      } else if (value == Locale('hi')) {
        setState(() {
          isSelectEng = false;
          isSelectHin = true;
          isSelectGuj = false;
          isSelectBn = false;
          isSelectAr = false;
          isSelectTa = false;
          isSelectMl = false;
        });
      } else if (value == Locale('gu')) {
        setState(() {
          isSelectEng = false;
          isSelectHin = false;
          isSelectGuj = true;
          isSelectBn = false;
          isSelectAr = false;
          isSelectTa = false;
          isSelectMl = false;
        });
      } else if (value == Locale('bn')) {
        setState(() {
          isSelectEng = false;
          isSelectHin = false;
          isSelectGuj = false;
          isSelectBn = true;
          isSelectAr = false;
          isSelectTa = false;
          isSelectMl = false;
        });
      } else if (value == Locale('ar')) {
        setState(() {
          isSelectEng = false;
          isSelectHin = false;
          isSelectGuj = false;
          isSelectBn = false;
          isSelectAr = true;
          isSelectTa = false;
          isSelectMl = false;
        });
      } else if (value == Locale('ta')) {
        setState(() {
          isSelectEng = false;
          isSelectHin = false;
          isSelectGuj = false;
          isSelectBn = false;
          isSelectAr = false;
          isSelectTa = true;
          isSelectMl = false;
        });
      } else if (value == Locale('ml')) {
        setState(() {
          isSelectEng = false;
          isSelectHin = false;
          isSelectGuj = false;
          isSelectBn = false;
          isSelectAr = false;
          isSelectTa = false;
          isSelectMl = true;
        });
      }
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
          Languages.of(context).selectLanguage,
          // textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        actions: [
          // IconButton(
          //   icon: null,
          //   onPressed: () {},
          // )
        ],
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Center(
                      child: SvgPicture.asset('assets/svg/Group 2015.svg'),
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectEng = false;
                          isSelectHin = true;
                          isSelectBn = false;
                          isSelectGuj = false;
                          isSelectAr = false;
                          // setLocale("hi");
                        });
                        changeLanguage(context, "hi");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            Languages.of(context).language1,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  isSelectHin ? Colors.red : Colors.grey[800],
                              fontWeight: isSelectHin
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 0,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectEng = true;
                          isSelectHin = false;
                          isSelectBn = false;
                          isSelectGuj = false;
                          isSelectAr = false;
                          // setLocale("en");
                        });
                        changeLanguage(context, "en");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            Languages.of(context).language2,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  isSelectEng ? Colors.red : Colors.grey[800],
                              fontWeight: isSelectEng
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 0,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectEng = false;
                          isSelectHin = false;
                          isSelectBn = true;
                          isSelectGuj = false;
                          isSelectAr = false;
                          // setLocale("en");
                        });
                        changeLanguage(context, "bn");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            Languages.of(context).language3,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelectBn ? Colors.red : Colors.grey[800],
                              fontWeight: isSelectBn
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 0,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectEng = false;
                          isSelectHin = false;
                          isSelectBn = false;
                          isSelectGuj = true;
                          isSelectAr = false;
                          // setLocale("en");
                        });
                        changeLanguage(context, "gu");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            Languages.of(context).language4,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  isSelectGuj ? Colors.red : Colors.grey[800],
                              fontWeight: isSelectGuj
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 0,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectEng = false;
                          isSelectHin = false;
                          isSelectBn = false;
                          isSelectGuj = false;
                          isSelectAr = false;
                          isSelectTa = true;
                          isSelectMl = false;
                          // setLocale("en");
                        });
                        changeLanguage(context, "ta");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            Languages.of(context).language6,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelectTa ? Colors.red : Colors.grey[800],
                              fontWeight: isSelectTa
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 0,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectEng = false;
                          isSelectHin = false;
                          isSelectBn = false;
                          isSelectGuj = false;
                          isSelectAr = false;
                          isSelectTa = false;
                          isSelectMl = true;
                          // setLocale("en");
                        });
                        changeLanguage(context, "ml");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            Languages.of(context).language7,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelectMl ? Colors.red : Colors.grey[800],
                              fontWeight: isSelectMl
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 0,
                      //thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectEng = false;
                          isSelectHin = false;
                          isSelectBn = false;
                          isSelectGuj = false;
                          isSelectAr = true;
                          isSelectTa = false;
                          isSelectMl = false;
                          // setLocale("en");
                        });
                        changeLanguage(context, "ar");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            Languages.of(context).language5,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelectAr ? Colors.red : Colors.grey[800],
                              fontWeight: isSelectAr
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 0,
                      //thickness: 1.5,
                    ),
                    SizedBox(height: 30),
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
