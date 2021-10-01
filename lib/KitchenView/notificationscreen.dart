import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/notifications.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/KitchenView/kitchendashboard.dart';

class NotificationScreen extends StatefulWidget {
  final String kitchenId;
  NotificationScreen(this.kitchenId);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // PushNotification().initializeKitchen();
  }

  Widget notificationList(List<Data> notList, String kitchenId) {
    return (notList.length == 0)
        ? Container(
            height: 100,
            child: Center(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
          )
        : ListView.builder(
            itemCount: notList.length,
            itemBuilder: (BuildContext context, int position) {
              return Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 100,
                //color: Colors.red[100],
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                //color: Colors.black12,
                                //width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "${notList[position].message}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: 80,
                                //color: Colors.black26,
                                child: Center(
                                  child: Text("${notList[position].dateTime}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.black38,
                            child: Text(
                              "${notList[position].description}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KitchenDashboard(),
          ),
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "Notifications",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        body: Stack(
          children: [
            BackgroundScreen(),
            SafeArea(
              child: FutureBuilder(
                future: getNotificationListData(widget.kitchenId),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? notificationList(snapshot.data, widget.kitchenId)
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
