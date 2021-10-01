import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/collapsing_navigation_drawer_user.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/dashboard.dart';
import 'package:wifyfood/UserHandlers/search_kitchen.dart';
import 'package:wifyfood/UserView/viewrestaurantscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:provider/provider.dart';

class SearchKitchenScreen extends StatefulWidget {
  final String userId, latitude, longitude, cityId, pic, fName, lName, add;
  final List<String> address;
  SearchKitchenScreen(this.userId, this.latitude, this.longitude, this.address,
      this.cityId, this.pic, this.fName, this.lName, this.add);
  @override
  _SearchKitchenScreenState createState() => _SearchKitchenScreenState();
}

class _SearchKitchenScreenState extends State<SearchKitchenScreen> {
  String string1, string2, string3, string4;
  List<KitchenList> searchResult = [];
  List<KitchenList> kitchenList = [];
  TextEditingController controller = new TextEditingController();

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

  Widget specialKitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildKitchenList() {
    return (kitchenList.length == 0)
        ? Center(
            child: Container(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
          )
        : ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
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
                                  //   image:
                                  //       AssetImage('assets/Indain Veg Thali.png'),
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
                          //color: Colors.black12,
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

  Widget buildSearchResults() {
    return new ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchResult.length,
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewRestaurantScreen(
                  widget.userId,
                  searchResult[position].id,
                  searchResult[position].kitchenName,
                  searchResult[position].location,
                  searchResult[position].rating,
                  searchResult[position].cuisine,
                  searchResult[position].fav,
                  searchResult[position].logo,
                  widget.address,
                  searchResult[position].bannerImage,
                  context.watch<CartCount>().lat,
                  context.watch<CartCount>().long,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  (searchResult[position].logo == "" ||
                          searchResult[position].logo == null)
                      ? Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                                'assets/svg/Icon feather-image.svg'),
                          ),
                        )
                      : kitchenLogo(searchResult[position].logo),
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${searchResult[position].kitchenName}',
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
                              (searchResult[position].rating == null)
                                  ? Container()
                                  : SvgPicture.asset(
                                      'assets/svg/Shape -1.svg',
                                      width: 14,
                                    ),
                              SizedBox(width: 5),
                              (searchResult[position].rating == null)
                                  ? Container()
                                  : Text(
                                      '${searchResult[position].rating.substring(0, 3)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              (searchResult[position].rating == null)
                                  ? Container()
                                  : SizedBox(width: 10),
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

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    kitchenList.forEach((kitchen) {
      kitchen.menuNameList.forEach((kitchen1) {
        if (kitchen1.dishname.contains(text)) searchResult.add(kitchen);
      });
      if (kitchen.kitchenName.contains(text)) searchResult.add(kitchen);
    });

    setState(() {});
  }

  Widget specialOfferListView(
      context, List<Special> specialOfferListData, String userId) {
    return (specialOfferListData.length == 0)
        ? Center(
            child: Container(
              child: Text(
                Languages.of(context).emptyList,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ),
          )
        : SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialOfferListData.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewRestaurantScreen(
                          userId,
                          specialOfferListData[position].id,
                          specialOfferListData[position].kitchenName,
                          specialOfferListData[position].location,
                          specialOfferListData[position].rating,
                          specialOfferListData[position].cuisine,
                          specialOfferListData[position].fav,
                          specialOfferListData[position].logo,
                          widget.address,
                          specialOfferListData[position].bannerImage,
                          context.watch<CartCount>().lat,
                          context.watch<CartCount>().long,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Container(
                      height: 120,
                      width: 80,
                      //color: Colors.black12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(10),
                            child: (specialOfferListData[position].logo == "" ||
                                    specialOfferListData[position].logo == null)
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/svg/Icon feather-image.svg'),
                                    ),
                                    width: 70,
                                    height: 70,
                                  )
                                : specialKitchenLogo(
                                    specialOfferListData[position].logo),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '50% Discount',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '${specialOfferListData[position].kitchenName}',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  @override
  void initState() {
    string1 = 'assets/svg/Icon feather-home.svg';
    string2 = 'assets/svg/blog.svg';
    string3 = 'assets/svg/register kitchen.svg';
    string4 = 'assets/svg/Icon feather-user.svg';
    getSearchKitchenData(widget.userId).then((value) {
      setState(() {
        kitchenList = value;
      });
    });
    print("${widget.address}");
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Image.asset(
              'assets/Icon feather-menu.png',
              scale: 1.2,
            ),
          ),
        ),
        title: Transform.translate(
          offset: Offset(-25, 0),
          child: Row(
            children: [
              Container(
                //color: Colors.black26,
                padding: const EdgeInsets.only(left: 0),
                //width: 20,
                child: Image.asset(
                  "assets/placeholder_2.png",
                  scale: 20,
                ),
              ),
              SizedBox(width: 2),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.address[0]}',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "${widget.add}",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      drawer: CollapsingNavigationDrawerUser(widget.userId, widget.address,
          widget.pic, widget.fName, widget.lName, widget.cityId),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
              child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  //qcolor: Colors.white,
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 20),
                    width: MediaQuery.of(context).size.width, //120,
                    height: 50,
                    child: Center(
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        //autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[700],
                          ),
                          border: InputBorder.none,
                          hintText: Languages.of(context).searchOnHome,
                          hintStyle: TextStyle(
                            //fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onChanged: onSearchTextChanged,
                        onTap: () {
                          controller.clear();
                          onSearchTextChanged('');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              searchResult.length != 0 || controller.text.isNotEmpty
                  ? buildSearchResults()
                  : buildKitchenList(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  Languages.of(context).special,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: FutureBuilder(
                  future: getSpecialOfferData(widget.userId),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? specialOfferListView(
                            context, snapshot.data, widget.userId)
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ))
        ],
      ),
      //bottomNavigationBar:
      //  BottomBar(string1, string2, string3, string4, widget.address),
    );
  }
}
