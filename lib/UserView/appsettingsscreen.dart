import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class AppSettingsScreen extends StatefulWidget {
  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          'App Settings',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
        ],
      ),
    );
  }
}
