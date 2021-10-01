import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/add_offer.dart';
import 'package:wifyfood/KitchenHandlers/menu_list.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:flushbar/flushbar.dart';
import 'package:wifyfood/Helper/push_notification.dart';

class AddOfferScreen extends StatefulWidget {
  final String kitchenId;
  AddOfferScreen(this.kitchenId);
  @override
  _AddOfferScreenState createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  String offerTitle;
  String description;
  String discountUpto;
  String validUpto;
  String product;
  bool selectphoto = false;
  String photoUpload;
  File image;
  List<String> discount = [
    "10%",
    "20%",
    "30%",
    "40%",
    "50%",
    "60%",
    "70%",
    "80%",
    "90%",
    "100%"
  ];
  List<String> productList = [];

  final _formKey = new GlobalKey<FormState>();

  final _picker = ImagePicker();
  DateTime date;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _offerTitleController = TextEditingController();

  Future<void> _selectValidDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date ?? now,
      firstDate: now,
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != date) {
      print("date: $picked");
      setState(() {
        date = picked;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _cropImage(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  File croppedImage;
  _cropImage(filePath) async {
    croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      compressQuality: 10,
      androidUiSettings: AndroidUiSettings(
        //toolbarTitle: "Edit Logo",
        toolbarColor: Colors.white,
        showCropGrid: true,
        hideBottomControls: true,
        lockAspectRatio: false,
      ),
    );
    setState(() {
      image = croppedImage;
      var imageBytes = image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      photoUpload = base64Image;

      selectphoto = true;
    });
  }

  void getProductList() {
    getMenuListData(widget.kitchenId).then((value) {
      if (value.length == 0) {
        productList.add("");
      } else if (value.length != 0) {
        for (var i = 0; i < value.length; i++) {
          //print(value[i].dishName);
          print(i);
          productList.add(value[i].dishName);
          //print("item[$i]: ${productList[i]}");
          print(productList);
        }
      } else {
        productList.add("");
      }
      print("hey");
      //productList.add("");
      setState(() {});
      //print(productList);
    });
  }

  Map<String, String> productOffer = new Map();

  @override
  void initState() {
    getProductList();
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        centerTitle: true,
        title: Text(
          Languages.of(context).newOffer,
          style: TextStyle(
              //color: Colors.grey[800],
              ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            BackgroundScreen(),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 30, left: 30, right: 30, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Languages.of(context).offerTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(25),
                        //color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              //controller: _offerTitleController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Offer Title*';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                // contentPadding:
                                //     EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText:
                                    Languages.of(context).ex + ' Offer Title',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (value) {
                                // _offerTitleController.text = value;
                                offerTitle = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context).disUpto,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(25),
                                //color: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          40,
                                  height: 60,
                                  child: Center(
                                    child: new DropdownButton(
                                      isExpanded: true,
                                      elevation: 0,
                                      hint: (discountUpto == null)
                                          ? Text(Languages.of(context).select)
                                          : Text("$discountUpto"),
                                      style: (discountUpto == null)
                                          ? TextStyle(
                                              color: Colors.grey[500],
                                            )
                                          : TextStyle(
                                              color: Colors.grey[900],
                                            ),
                                      value: discountUpto,
                                      items: discount.map((dis) {
                                        return DropdownMenuItem(
                                          child: new Text(dis),
                                          value: dis,
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          discountUpto = value;
                                        });
                                        print("$discountUpto");
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context).offValid,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(25),
                                //color: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          40,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: TextFormField(
                                      readOnly: true,
                                      //keyboardType: TextInputType.datetime,
                                      controller: _textEditingController,
                                      onTap: () async {
                                        // Below line stops keyboard from appearing
                                        //FocusScope.of(context).requestFocus(new FocusNode());
                                        //yyyy/MM/dd
                                        await _selectValidDate(context);
                                        _textEditingController.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(date);
                                        validUpto = _textEditingController.text;
                                        print(validUpto);
                                      },
                                      // validator: (value) {
                                      //   if (value.isEmpty) {
                                      //     return 'Required*';
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        border: InputBorder.none,
                                        hintText: 'dd/mm/yyyy',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500),
                                      ),
                                      // onChanged: (value) {
                                      //   validUpto = value;
                                      // },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        Languages.of(context).selectProd,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(25),
                        //color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Center(
                            child: new DropdownButton(
                              isExpanded: true,
                              elevation: 0,
                              hint: (product == null)
                                  ? Text(Languages.of(context).select)
                                  : Text("$product"),
                              style: (product == null)
                                  ? TextStyle(
                                      color: Colors.grey[500],
                                    )
                                  : TextStyle(
                                      color: Colors.grey[900],
                                    ),
                              value: product,
                              items: productList.map((dis) {
                                return DropdownMenuItem(
                                  child: new Text(dis),
                                  value: dis,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  product = value;
                                });
                                print("$product");
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        Languages.of(context).offerDes,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(25),
                        //color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 120,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Enter Offer Description*';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: Languages.of(context).enterDesOffer,
                              hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500),
                            ),
                            maxLines: 50,
                            onChanged: (value) {
                              description = value;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        Languages.of(context).uploadBackPic,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          //color: Colors.white,
                          child: Container(
                            // height: 120,
                            // width: 120,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: selectphoto
                                  ? DecorationImage(
                                      image: FileImage(image),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                            ),
                            child: selectphoto
                                ? null
                                : Center(
                                    child: SvgPicture.asset(
                                        'assets/svg/Icon feather-image.svg'),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          if (_offerTitleController.text.isEmpty) {
                            Flushbar(
                              //flushbarStyle: FlushbarStyle.GROUNDED,
                              icon: Icon(Icons.error),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Error",
                              message: "Offer Title is required",
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ).show(context);
                          } else if (discountUpto == null) {
                            Flushbar(
                              //flushbarStyle: FlushbarStyle.GROUNDED,
                              icon: Icon(Icons.error),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Error",
                              message: "Select Discount",
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ).show(context);
                          } else if (validUpto == null) {
                            Flushbar(
                              //flushbarStyle: FlushbarStyle.GROUNDED,
                              icon: Icon(Icons.error),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Error",
                              message: "Select Valid Date",
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ).show(context);
                          } else if (product == null) {
                            Flushbar(
                              //flushbarStyle: FlushbarStyle.GROUNDED,
                              icon: Icon(Icons.error),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Error",
                              message: "Select Product",
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ).show(context);
                          } else if (description == null || description == "") {
                            Flushbar(
                              //flushbarStyle: FlushbarStyle.GROUNDED,
                              icon: Icon(Icons.error),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Error",
                              message: "Enter Description",
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ).show(context);
                          } else if (photoUpload == null) {
                            Flushbar(
                              //flushbarStyle: FlushbarStyle.GROUNDED,
                              icon: Icon(Icons.error),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Error",
                              message: "Select Offer Image",
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ).show(context);
                          } else {
                            getAddOfferData(
                                    offerTitle,
                                    discountUpto,
                                    widget.kitchenId,
                                    validUpto,
                                    product,
                                    description,
                                    photoUpload)
                                .then((value) {
                              Fluttertoast.showToast(
                                msg: "New Offer Created",
                                fontSize: 20,
                                textColor: Colors.white,
                                backgroundColor: Colors.blue,
                                toastLength: Toast.LENGTH_LONG,
                              );
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(28, 149, 71, 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              Languages.of(context).save,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
