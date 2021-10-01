import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wifyfood/Helper/bottom_navigation_bar.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserHandlers/newkitchen.dart';
import 'package:wifyfood/UserView/viewrestaurantscreen.dart';

class NewKitchenScreen extends StatefulWidget {
  final List<String> address;
  final String userId, cityId;
  NewKitchenScreen(this.address, this.userId, this.cityId);
  @override
  _NewKitchenScreenState createState() => _NewKitchenScreenState();
}

class _NewKitchenScreenState extends State<NewKitchenScreen> {
  String string1, string2, string3, string4, string5;
  //List<KitchenList> kitchenList = [];

  Widget kitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildKitchenList(List<KitchenList> kitchenList) {
    return (kitchenList.length == 0)
        ? Center(
            child: Container(
              child: Text(
                Languages.of(context).service,
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
          )
        : ListView.builder(
            itemCount: kitchenList.length,
            itemBuilder: (context, position) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewRestaurantScreen(
                        widget.userId,
                        kitchenList[position].id,
                        kitchenList[position].kitchenName,
                        kitchenList[position].location,
                        kitchenList[position].rating,
                        kitchenList[position].cuisine,
                        kitchenList[position].fav,
                        kitchenList[position].logo,
                        widget.address,
                        kitchenList[position].bannerImage,
                        context.watch<CartCount>().lat,
                        context.watch<CartCount>().long,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (kitchenList[position].logo == "" ||
                                kitchenList[position].logo == null)
                            ? Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  // image: DecorationImage(
                                  //   image: MemoryImage(bytes),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/svg/Icon feather-image.svg'),
                                ),
                              )
                            : kitchenLogo(kitchenList[position].logo),
                        SizedBox(width: 20),
                        Container(
                          width: MediaQuery.of(context).size.width - 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${kitchenList[position].kitchenName}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Kitchen',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 20,
                                child: Row(
                                  children: [
                                    (kitchenList[position].rating == null)
                                        ? Container()
                                        : SvgPicture.asset(
                                            'assets/svg/Shape -1.svg',
                                            width: 14,
                                          ),
                                    SizedBox(width: 5),
                                    (kitchenList[position].rating == null)
                                        ? Container()
                                        : Text(
                                            '${kitchenList[position].rating.substring(0, 3)}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                    (kitchenList[position].rating == null)
                                        ? Container()
                                        : SizedBox(width: 10),
                                    // Image.asset('assets/Vector Smart Object-12.png'),
                                    SvgPicture.asset('assets/svg/clock.svg'),
                                    SizedBox(width: 5),
                                    Text(
                                      '40 min',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
  void initState() {
    print("New Kitchens Screen");
    string1 = 'assets/svg/Icon feather-home.svg';
    string2 = 'assets/svg/blog.svg';
    string3 = 'assets/svg/register kitchen (1).svg';
    string4 = 'assets/svg/Icon feather-user.svg';
    string5 = 'assets/svg/Tracking.svg';
    // getNewKitchenListData(widget.userId).then((value) {
    //   setState(() {
    //     kitchenList = value;
    //   });
    // });
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
          'New Kitchens',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: FutureBuilder(
              future: getNewKitchenListData(widget.userId),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? buildKitchenList(snapshot.data)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomBar(
      //     string1,
      //     string2,
      //     string3,
      //     string4,
      //     string5,
      //     widget.address,
      //     widget.cityId,
      //     [false, false, false, true, false]),
    );
  }
}
