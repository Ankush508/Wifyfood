import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/help.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String content = "";

  @override
  void initState() {
    getHelpData().then((value) {
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
          Languages.of(context).help,
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
            child: Container(
              //margin: EdgeInsets.only(top: 80),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
