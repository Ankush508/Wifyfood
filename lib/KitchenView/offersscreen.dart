import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/KitchenHandlers/offers.dart';

class OffersScreen extends StatefulWidget {
  final String kitchenId;
  OffersScreen(this.kitchenId);
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  bool click1 = true;
  bool click2 = false;

  Widget offerImage(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget currentOffer(List<CurrentOffer> currentOffer, String kicthenId) {
    return (currentOffer.length == 0)
        ? Container(
            height: 200,
            child: Center(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900], fontSize: 16),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: currentOffer.length,
            itemBuilder: (BuildContext context, int position) {
              return offerImage(currentOffer[position].image);
            },
          );
  }

  Widget closedOffer(List<ClosedOffer> closedOffer, String kicthenId) {
    return (closedOffer.length == 0)
        ? Container(
            height: 200,
            child: Center(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900], fontSize: 16),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: closedOffer.length,
            itemBuilder: (BuildContext context, int position) {
              return offerImage(closedOffer[position].image);
            },
          );
  }

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
          Languages.of(context).offer,
          style: TextStyle(),
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
                              width:
                                  (MediaQuery.of(context).size.width - 30) / 2,
                              child: click1
                                  ? Container(
                                      height: 50,
                                      width:
                                          (MediaQuery.of(context).size.width -
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
                                          Languages.of(context).current,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 50,
                                      color: Colors.transparent,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                      child: Center(
                                        child: Text(
                                          Languages.of(context).current,
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
                              width:
                                  (MediaQuery.of(context).size.width - 30) / 2,
                              child: click2
                                  ? Container(
                                      height: 50,
                                      width:
                                          (MediaQuery.of(context).size.width -
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
                                          Languages.of(context).closed,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 50,
                                      color: Colors.transparent,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                      child: Center(
                                        child: Text(
                                          Languages.of(context).closed,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    click2
                        ? FutureBuilder(
                            future: getClosedOfferData(widget.kitchenId),
                            builder: (context, snapshot) {
                              return snapshot.data != null
                                  ? closedOffer(snapshot.data, widget.kitchenId)
                                  : Container(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                            },
                          )
                        : FutureBuilder(
                            future: getCurrentOfferData(widget.kitchenId),
                            builder: (context, snapshot) {
                              return snapshot.data != null
                                  ? currentOffer(
                                      snapshot.data, widget.kitchenId)
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
          ),
        ],
      ),
    );
  }
}
