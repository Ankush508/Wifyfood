import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:wifyfood/Helper/bottom_navigation_bar.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/blog.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/UserView/viewrestaurantscreen.dart';

class BlogScreen extends StatefulWidget {
  final List<String> address;
  final String cityId, userId;
  BlogScreen(this.address, this.cityId, this.userId);
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String string1, string2, string3, string4, string5;
  List<bool> isClick = [false];

  Widget logo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
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
        width: 80,
        height: 80,
      ),
    );
  }

  Widget kitchen(List<UserBlog> blog) {
    return (blog.length == 0)
        ? Center(
            child: Text(Languages.of(context).emptyList),
          )
        : ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: blog.length,
            itemBuilder: (BuildContext context, int position) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewRestaurantScreen(
                        widget.userId,
                        blog[position].kitchenId,
                        blog[position].kitchenName,
                        blog[position].location,
                        blog[position].rate,
                        blog[position].cuisine,
                        "null",
                        blog[position].logo,
                        widget.address,
                        blog[position].bannerImage,
                        context.watch<CartCount>().lat,
                        context.watch<CartCount>().long,
                      ),
                    ),
                  );
                  setState(() {
                    isClick[0] = !isClick[0];
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Container(
                        //   height: 80,
                        //   width: 80,
                        //   decoration: BoxDecoration(
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(10),
                        //     image: DecorationImage(
                        //       image: AssetImage('assets/Indain Veg Thali.png'),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        logo(blog[position].logo),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${blog[position].kitchenName}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width - 180,
                              child: Text(
                                "${blog[position].message}",
                                style: TextStyle(
                                  fontSize: 12,
                                  // color: Colors.red,

                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: isClick[0] ? 100 : 2,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 20,
                              child: Row(
                                children: [
                                  // (kitchenList[position].rating == null)
                                  //     ? Container()
                                  //     :
                                  (blog[position].rate == null)
                                      ? Container()
                                      : SvgPicture.asset(
                                          'assets/svg/Shape -1.svg',
                                          width: 14,
                                        ),
                                  SizedBox(width: 5),
                                  // (kitchenList[position].rating == null)
                                  //     ? Container()
                                  //     :
                                  (blog[position].rate == null)
                                      ? Container()
                                      : Text(
                                          '${blog[position].rate.substring(0, 3)}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                  // (kitchenList[position].rating == null)
                                  //     ? Container()
                                  //     :
                                  // SizedBox(width: 10),
                                  // // Image.asset('assets/Vector Smart Object-12.png'),
                                  // SvgPicture.asset('assets/svg/clock.svg'),
                                  // SizedBox(width: 5),
                                  // Text(
                                  //   '40 min',
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset('assets/svg/red drop down.svg'),
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
    string1 = 'assets/svg/Icon feather-home.svg';
    string2 = 'assets/svg/blog (1).svg';
    string3 = 'assets/svg/register kitchen.svg';
    string4 = 'assets/svg/Icon feather-user.svg';
    string5 = 'assets/svg/Tracking.svg';
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
          'Blog',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: ListView(
              children: [
                // kitchen(),
                // kitchen(),
                // kitchen(),
                // kitchen(),
                // kitchen(),
                FutureBuilder(
                  future: getUserBlogListData(widget.userId),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? kitchen(snapshot.data)
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ],
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
      //     [false, true, false, false, false]),
    );
  }
}
