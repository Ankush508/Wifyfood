import 'package:flutter/material.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/trans_list.dart';

class PaymentListScreen extends StatefulWidget {
  final String userId;
  PaymentListScreen(this.userId);
  @override
  _PaymentListScreenState createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  Widget transactionList(List<TransactionList> transList, String userId) {
    return (transList.length == 0)
        ? Center(
            child: Container(
              child: Text(
                "List is Empty",
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
          )
        : ListView.builder(
            itemCount: transList.length,
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
                                  "Transaction Id: ${transList[position].orderId}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    //fontWeight: FontWeight.w400,
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
                                  child: Text(
                                    "${transList[position].dateTime}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w400,
                                    ),
                                  ),
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
                              "${transList[position].kitchenName}",
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
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.black38,
                            child: Text(
                              "Amount: ${transList[position].transAmount}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
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
  void initState() {
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: FutureBuilder(
              future: getTransListData(widget.userId),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? transactionList(snapshot.data, widget.userId)
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
    );
  }
}
