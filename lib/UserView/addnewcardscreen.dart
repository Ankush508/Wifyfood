import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/add_card.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class AddNewCardScreen extends StatefulWidget {
  final String userId;
  AddNewCardScreen(this.userId);
  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  String cardNumber;
  String validThrough;
  String cvv;
  String nameOnCard;
  bool check = false;

  final _formKey = new GlobalKey<FormState>();

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
          'Add New Card',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        actions: [],
      ),
      body: Form(
        key: _formKey,
        // ignore: deprecated_member_use
        autovalidate: true,
        child: Stack(
          children: [
            BackgroundScreen(),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      Center(
                        child: SvgPicture.asset('assets/svg/Group 2007.svg'),
                      ),
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.red)),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(16),
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required*';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Card Number',
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              cardNumber = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Required*';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Valid Through (MM/YYYY)',
                                hintStyle: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                              onChanged: (value) {
                                validThrough = value;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(3),
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Required*';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'CVV',
                                hintStyle: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                              onChanged: (value) {
                                cvv = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.red)),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required*';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'NAME ON CARD',
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                          ),
                          onChanged: (value) {
                            nameOnCard = value;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                if (check == false) {
                                  check = true;
                                } else
                                  check = false;
                              });
                            },
                            value: check,
                          ),
                          Text(
                            'Securely save card details',
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            if (check == true) {
                              getAddCardData(
                                      widget.userId,
                                      cardNumber,
                                      validThrough,
                                      cvv,
                                      nameOnCard,
                                      check.toString())
                                  .then((value) {
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
                              //     builder: (context) => BillDetailsScreen(),
                              //   ),
                              // );
                            } else if (check == false) {
                              Fluttertoast.showToast(
                                msg: "Please give consent first",
                                fontSize: 20,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => BillDetailsScreen(),
                          //   ),
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[800],
                            child: Container(
                              height: 50, //MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Center(
                                child: Text(
                                  'ADD CARD',
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
            ),
          ],
        ),
      ),
    );
  }
}
