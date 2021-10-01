import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/UserHandlers/search_kitchen.dart';
import 'package:wifyfood/UserView/viewrestaurantscreen.dart';

class ViewAllKitchenScreen extends StatefulWidget {
  final String userId;
  final List<String> address;
  ViewAllKitchenScreen(this.userId, this.address);
  @override
  _ViewAllKitchenScreenState createState() => _ViewAllKitchenScreenState();
}

class _ViewAllKitchenScreenState extends State<ViewAllKitchenScreen> {
  Widget kitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Container(
      height: 150,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: (bytes.length < 10)
            ? DecorationImage(
                image: AssetImage("assets/no image.jpg"),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: MemoryImage(bytes),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget buildKitchenList(List<KitchenList> kitchenList) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: kitchenList.length,
      itemBuilder: (context, position) {
        // var logo = kitchenList[position].logo;
        // File image = base64Decode();
        //final decodeBytes = base64Decode(kitchenList[position].logo);
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Container(
                //   height: 70,
                //   width: 70,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     image: DecorationImage(
                //       image: AssetImage('assets/Indain Veg Thali.png'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                kitchenLogo(kitchenList[position].logo),
                // SizedBox(width: 20),
                // image(kitchenList[position].logo),
                SizedBox(width: 10),
                Container(
                  // color: Colors.black12,
                  width: MediaQuery.of(context).size.width - 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${kitchenList[position].kitchenName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '${kitchenList[position].location}',
                        style: TextStyle(
                          fontSize: 12,
                          //color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
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
        );
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
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 10),
                FutureBuilder(
                  future: getSearchKitchenData(widget.userId),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? buildKitchenList(snapshot.data)
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          )
        ],
      ),
    );
  }
}
