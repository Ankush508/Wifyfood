import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Language/text_keys.dart';

class OrderConfirmScreen extends StatefulWidget {
  final String userId;
  final String addressType;
  final String address;
  final String location;
  OrderConfirmScreen(
      this.userId, this.addressType, this.address, this.location);
  @override
  _OrderConfirmScreenState createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  void initState() {
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        //iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.red,
            ),
          ),
          SafeArea(
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/Vector Smart Object - check.png',
                            scale: 1.1,
                          ),
                        ),
                        SizedBox(height: 29),
                        Center(
                          child: Text(
                            Languages.of(context).ty,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            Languages.of(context).orderCon,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: 100),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 10),
                            // Text(
                            //   '1 ' + Languages.of(context).foodProd,
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     //color: Colors.grey[800],
                            //   ),
                            // ),
                            // SizedBox(height: 5),
                            // Text(
                            //   'Lorem Ipsum',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     color: Colors.red,
                            //   ),
                            // ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/svg/Group 2005.svg'),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.addressType}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        //  color: Colors.grey[800],
                                      ),
                                    ),
                                    Text(
                                      '${widget.address}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w600,
                                        //color: Colors.grey[800],
                                      ),
                                    ),
                                    Text(
                                      '${widget.location}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w600,
                                        //  color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/svg/Group 2004.svg'),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Languages.of(context).estTime,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        //color: Colors.grey[800],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '2 hours',
                                      style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // SizedBox(height: 20),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             TrackOrderScreen(widget.userId),
                            //       ),
                            //     );
                            //   },
                            //   child: Text(
                            //     Languages.of(context).orderStat,
                            //     style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.red,
                            //         decoration: TextDecoration.underline),
                            //   ),
                            // ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                //Navigator.pop(context);
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green[800],
                                child: Container(
                                  height:
                                      50, //MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      Languages.of(context).con,
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
