import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/about_wifyfood.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class AboutWifyFoodScreen extends StatefulWidget {
  @override
  _AboutWifyFoodScreenState createState() => _AboutWifyFoodScreenState();
}

class _AboutWifyFoodScreenState extends State<AboutWifyFoodScreen> {
  String content = "";
  @override
  void initState() {
    getAboutWifyfoodData().then((value) {
      setState(() {
        content = value.response.content;
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
          Languages.of(context).aboutWify,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
          // Container(
          //   child: Column(
          //     children: [
          //       Spacer(),
          //       Padding(
          //         padding: EdgeInsets.only(left: 25.0),
          //         child: Image.asset(
          //           'assets/wify girl.png',
          //           scale: 1.3,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   child: Column(
          //     children: [
          //       Spacer(),
          //       Image.asset(
          //         'assets/Group 671.png',
          //         scale: 1,
          //       ),
          //     ],
          //   ),
          // ),
          SafeArea(
            //margin: EdgeInsets.only(top: 80),
            child: Container(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      content,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Transform.translate(
                      offset: Offset(0, 30),
                      child: Image.asset(
                        'assets/Group 2316.png',
                        fit: BoxFit.fill,
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
