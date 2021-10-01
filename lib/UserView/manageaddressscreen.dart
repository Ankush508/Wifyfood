import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifyfood/UserHandlers/address_list.dart';
import 'package:wifyfood/UserHandlers/remove_address.dart';
import 'package:wifyfood/UserView/addnewaddressscreen.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class ManageAddressScreen extends StatefulWidget {
  final String userId;
  ManageAddressScreen(this.userId);
  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  Widget listViewWidget(
      List<Data> addressData, String userId, BuildContext context) {
    return addressData.length == 0
        ? Center(
            child: Text('No Address Available'),
          )
        : Container(
            //width: MediaQuery.of(context).size.width * 0.25,
            // margin: EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: addressData.length + 1,
              itemBuilder: (context, position) {
                return (position == addressData.length)
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddNewAddressScreen(widget.userId),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 20, top: 10),
                          child: Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[800],
                              child: Container(
                                height:
                                    40, //MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Center(
                                  child: Text(
                                    '+ ' + Languages.of(context).addNewAdd,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        //color: Colors.red[200],
                        padding: const EdgeInsets.only(left: 5),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/Group 1998.svg'),
                            SizedBox(width: 10),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${addressData[position].addressType}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700]),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${addressData[position].address}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.grey[700]),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${addressData[position].location}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.grey[700]),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.all(30),
                                          height: 200,
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(Languages.of(context)
                                                  .deleteAdd),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      //color: Colors.amber,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        height: 40,
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(
                                                            Languages.of(
                                                                    context)
                                                                .cancel,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .grey[700]),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      getRemoveAddress(
                                                              userId,
                                                              addressData[
                                                                      position]
                                                                  .id)
                                                          .then((value) {
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.red,
                                                      child: Container(
                                                        height: 40,
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(
                                                            Languages.of(
                                                                    context)
                                                                .delete,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
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
          Languages.of(context).manAdd,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getAddressListData(widget.userId),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? listViewWidget(snapshot.data, widget.userId, context)
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
