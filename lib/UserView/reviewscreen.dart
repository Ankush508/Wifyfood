import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/review.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class ReviewScreen extends StatefulWidget {
  final String userId, kitchenId;
  ReviewScreen(this.userId, this.kitchenId);
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double initialRate = 5;
  double rate = 5;
  String message = "null";

  @override
  void initState() {
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).review,
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        actions: [
          // IconButton(
          //   icon: null,
          //   onPressed: () {},
          // )
        ],
      ),
      body: Stack(
        children: [
          BackgroundScreen(),
          SafeArea(
            child: Container(
              //padding: EdgeInsets.only(top: 20, bottom: 20),
              child: ListView(
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: RatingBar.builder(
                      glow: false,
                      initialRating: initialRate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate = rating;
                        });
                        print(rating);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: Languages.of(context).writeRev),
                          maxLines: 10,
                          onChanged: (value) {
                            setState(() {
                              message = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  //Spacer(),
                  GestureDetector(
                    onTap: () {
                      getReviewData(widget.userId, rate.toString(), message,
                              widget.kitchenId)
                          .then((value) {
                        print("rating: $rate");
                        print("${value.message}");
                        Fluttertoast.showToast(
                          msg: "${value.message}",
                          fontSize: 20,
                          textColor: Colors.white,
                          backgroundColor: Colors.blue,
                          toastLength: Toast.LENGTH_LONG,
                        );
                      });
                      Navigator.pop(context);
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => HomeScreen(),
                      //   ),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[800],
                        child: Container(
                          height: 50, //MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(
                            child: Text(
                              Languages.of(context).submit,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
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
