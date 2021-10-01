import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/add_menu.dart';
import 'package:wifyfood/UserHandlers/category_list.dart';
import 'package:wifyfood/Language/text_keys.dart';

class AddSpecialItemScreen extends StatefulWidget {
  final String userId;
  final String kitchenName;
  final String email;
  final String logo;
  AddSpecialItemScreen(this.userId, this.kitchenName, this.email, this.logo);
  @override
  _AddSpecialItemScreenState createState() => _AddSpecialItemScreenState();
}

class _AddSpecialItemScreenState extends State<AddSpecialItemScreen> {
  File image;
  bool showFront = true;
  bool selectphoto = false;
  bool _isLoading = false;
  String dishName;
  String descrption;
  //String price;
  String fullprice;
  String halfprice = "0";
  String foodType;
  String foodQuan = "2";
  String category;
  String categoryNumber = "8";
  String maxQuantity;
  String photoUpload;
  String videoUpload;
  String prepTime;
  String selectedDate;
  String isRepeat = "no";
  List<String> foodtype = ["Full & Half", "Full"];
  List<String> categoryList = [];
  List<String> isRepeatList = ["Show on particular day", "Repeat on weekday"];
  List<String> weekDays = ["1", "0", "0", "0", "0", "0", "0"];
  List<bool> isClickDays = [true, false, false, false, false, false, false];
  // int _isRepeat = 0;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  bool field1 = false,
      field2 = false,
      field3 = false,
      field4 = false,
      field5 = false,
      field6 = false;
  DateTime date;

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: now, // date ?? DateTime(2001),
      firstDate: now,
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != date) {
      print("date selected: $picked");
      setState(() {
        date = picked;
      });
    }
  }

  // final _picker = ImagePicker();
  Future getImage() async {
    // final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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
      iosUiSettings: IOSUiSettings(),
    );

    setState(() {
      image = croppedImage;
      var imageBytes = image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      photoUpload = base64Image;

      selectphoto = true;
    });
  }

  void getCategoryList() {
    getCategoryListData(widget.userId).then((value) {
      for (var i = 0; i < value.length; i++) {
        //print(i);
        categoryList.add(value[i].name);
        //print(categoryList);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getCategoryList();
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            BackgroundScreen(),
            BackgroundCircle(),
            Container(
              padding: EdgeInsets.only(top: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              alignment: Alignment.topRight,
              child: SvgPicture.asset('assets/svg/wify girl.svg'),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      //color: Colors.black38,
                      padding: EdgeInsets.only(left: 30, bottom: 20),
                      height: 240,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            Languages.of(context).add,
                            style: TextStyle(
                              color: Colors.deepOrange[700],
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          //SizedBox(height: 10),
                          // Text(
                          //   // Languages.of(context).menu,
                          //   "Special",
                          //   style: TextStyle(
                          //     color: Colors.deepOrange[700],
                          //     fontSize: 30,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          Text(
                            Languages.of(context).menu,
                            style: TextStyle(
                              color: Colors.deepOrange[700],
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.red[50],
                      padding: EdgeInsets.only(
                          top: 5, left: 30, right: 30, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context).dishName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(25),
                            //color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (field1 == true) {
                                      return 'Enter Dish Name*';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    border: InputBorder.none,
                                    hintText:
                                        Languages.of(context).ex + ' Dal Fry',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onChanged: (value) {
                                    dishName = value;
                                    setState(() {
                                      if (value.isEmpty) {
                                        field1 = true;
                                      } else
                                        field1 = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            Languages.of(context).des,
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (field2 == true) {
                                    return 'Enter Description*';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Languages.of(context).enterDes,
                                  hintStyle: TextStyle(
                                      //fontSize: 18,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.bold),
                                ),
                                maxLines: 50,
                                onChanged: (value) {
                                  descrption = value;
                                  setState(() {
                                    if (value.isEmpty) {
                                      field2 = true;
                                    } else
                                      field2 = false;
                                  });
                                },
                              ),
                            ),
                          ),
                          /* const SizedBox(height: 15),
                          Text(
                            Languages.of(context).foodQuan,
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Center(
                                child: new DropdownButton(
                                  isExpanded: true,
                                  elevation: 0,
                                  hint: (foodType == null)
                                      ? Text(Languages.of(context).select)
                                      : Text("$foodType"),
                                  style: (foodType == null)
                                      ? TextStyle(
                                          color: Colors.grey[500],
                                        )
                                      : TextStyle(
                                          color: Colors.grey[900],
                                        ),
                                  value: foodType,
                                  items: foodtype.map((dis) {
                                    return DropdownMenuItem(
                                      child: new Text(dis),
                                      value: dis,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == "Full & Half") {
                                        foodQuan = "1";
                                        // fullprice = "0";
                                        // halfprice = price;
                                      } else if (value == "Full") {
                                        foodQuan = "2";
                                        // fullprice = price;
                                        halfprice = "0";
                                      }
                                      foodType = value;
                                    });
                                    print("$foodType");
                                    print("$foodQuan");
                                  },
                                ),
                              ),
                            ),
                          ),*/
                          const SizedBox(height: 15),
                          Text(
                            Languages.of(context).fullPrice,
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (field3 == true) {
                                      return 'Enter Price*';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    border: InputBorder.none,
                                    hintText:
                                        Languages.of(context).ex + ' 150.00',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onChanged: (value) {
                                    fullprice = value;
                                    setState(() {
                                      if (value.isEmpty) {
                                        field3 = true;
                                      } else
                                        field3 = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          (foodQuan == "2")
                              ? Container()
                              : Text(
                                  Languages.of(context).halfPrice,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          (foodQuan == "2")
                              ? Container()
                              : const SizedBox(height: 15),
                          (foodQuan == "2")
                              ? Container()
                              : Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(25),
                                  //color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (field4 == true) {
                                            return 'Enter Price*';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          border: InputBorder.none,
                                          hintText: Languages.of(context).ex +
                                              ' 150.00',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (value) {
                                          halfprice = value;
                                          setState(() {
                                            if (value.isEmpty) {
                                              field4 = true;
                                            } else
                                              field4 = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                          /* const SizedBox(height: 15),
                          Text(
                            Languages.of(context).selectCat,
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Center(
                                child: new DropdownButton(
                                  isExpanded: true,
                                  elevation: 0,
                                  hint: (category == null)
                                      ? Text(Languages.of(context).select)
                                      : Text("$category"),
                                  style: (category == null)
                                      ? TextStyle(
                                          color: Colors.grey[500],
                                        )
                                      : TextStyle(
                                          color: Colors.grey[900],
                                        ),
                                  value: category,
                                  items: categoryList.map((dis) {
                                    return DropdownMenuItem(
                                      child: new Text(dis),
                                      value: dis,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == "Recommended") {
                                        categoryNumber = "1";
                                      } else if (value == "Soups") {
                                        categoryNumber = "2";
                                      } else if (value == "Quick Bites") {
                                        categoryNumber = "3";
                                      } else if (value == "Starters") {
                                        categoryNumber = "4";
                                      } else if (value == "Main Course") {
                                        categoryNumber = "5";
                                      } else if (value ==
                                          "Family Binge Combos") {
                                        categoryNumber = "6";
                                      } else if (value == "Beverage Combos") {
                                        categoryNumber = "7";
                                      }
                                      category = value;
                                    });
                                    print("$category");
                                    print("$categoryNumber");
                                  },
                                ),
                              ),
                            ),
                          ),*/
                          const SizedBox(height: 15),
                          Text(
                            "Preparation Time",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 0),
                          Text(
                            "(In Minutes)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(25),
                            //color: Colors.white,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (field6 == true) {
                                      return 'Enter Time*';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    border: InputBorder.none,
                                    hintText: Languages.of(context).ex + ' 5',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onChanged: (value) {
                                    prepTime = value;
                                    setState(() {
                                      if (value.isEmpty) {
                                        field6 = true;
                                      } else
                                        field6 = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            Languages.of(context).maxQuan,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 0),
                          Text(
                            "(Enter cooking capacity of the Item)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(25),
                            //color: Colors.white,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (field5 == true) {
                                      return 'Enter Maximum Quantity*';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    border: InputBorder.none,
                                    hintText: Languages.of(context).ex + ' 10',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onChanged: (value) {
                                    maxQuantity = value;
                                    setState(() {
                                      if (value.isEmpty) {
                                        field5 = true;
                                      } else
                                        field5 = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          /*Container(
                            width: double.infinity,
                            // height: 40,
                            // color: Colors.black12,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Radio(
                                      value: 0,
                                      groupValue: this._isRepeat,
                                      onChanged: (int value) {
                                        print("Roll No: $value");
                                        setState(() {
                                          this._isRepeat = value;
                                          // dep = "";
                                          // depName = "";
                                          // doj = "";
                                          // desg = "";
                                          // desName = "";
                                        });
                                      },
                                    ),
                                    new Text(
                                      'Show on particular day',
                                      style: new TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    new Radio(
                                      value: 1,
                                      groupValue: this._isRepeat,
                                      onChanged: (int value) {
                                        print("Emp Id: $value");
                                        setState(() {
                                          this._isRepeat = value;
                                          // clss = "";
                                          // clssName = "";
                                        });
                                      },
                                    ),
                                    new Text(
                                      'Repeat on Weekday',
                                      style: new TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),*/
                          const SizedBox(height: 15),
                          Text(
                            // Languages.of(context).maxQuan,
                            "Select item addition type",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: DropdownButton(
                                isExpanded: true,
                                elevation: 0,
                                hint: (isRepeat == "no")
                                    ? Text(
                                        "Show on particular day",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      )
                                    : Text(
                                        "Repeat on weekday",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                underline: Container(),
                                icon: Container(),
                                // style: TextStyle(color: Colors.white),

                                // value: bGroup,
                                items: isRepeatList.map((String dis) {
                                  return DropdownMenuItem<String>(
                                    child: Text(dis),
                                    value: dis,
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  print("Department: $newValue");
                                  setState(() {
                                    if (newValue == "Show on particular day") {
                                      isRepeat = "no";
                                    } else
                                      isRepeat = "yes";
                                  });
                                  // print("Department Id: $dep");
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          (isRepeat == "no")
                              ? Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(30),
                                  //color: Colors.white,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: _textEditingController,
                                        onTap: () async {
                                          await _selectDateOfBirth(context);
                                          _textEditingController.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(date);
                                          selectedDate =
                                              _textEditingController.text;
                                          print("Selected Date: $selectedDate");
                                          setState(() {
                                            if (_textEditingController
                                                .text.isEmpty) {
                                              field2 = true;
                                            } else
                                              field2 = false;
                                          });
                                        },
                                        validator: (value) {
                                          if (field2 == true) {
                                            return 'Select Date*';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          border: InputBorder.none,
                                          hintText:
                                              "Select Date", // Languages.of(context).dob,
                                          hintStyle: TextStyle(
                                            //fontSize: 18,
                                            color: Colors.grey[700],
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          // (isRepeat == "yes")
                          //     ? Material(
                          //         elevation: 10,
                          //         borderRadius: BorderRadius.circular(25),
                          //         child: Container(
                          //           padding: const EdgeInsets.only(
                          //               left: 20, right: 20),
                          //           width: MediaQuery.of(context).size.width,
                          //           height: 60,
                          //           child: DropdownButton(
                          //             isExpanded: true,
                          //             elevation: 0,
                          //             hint: (isRepeat == "no")
                          //                 ? Text(
                          //                     "Show on particular day",
                          //                     style: TextStyle(
                          //                         fontSize: 14,
                          //                         fontWeight: FontWeight.w500),
                          //                   )
                          //                 : Text(
                          //                     "Repeat on weekday",
                          //                     style: TextStyle(
                          //                         fontSize: 14,
                          //                         fontWeight: FontWeight.w500),
                          //                   ),
                          //             underline: Container(),
                          //             icon: Container(),
                          //             // style: TextStyle(color: Colors.white),

                          //             // value: bGroup,
                          //             items: isRepeatList.map((String dis) {
                          //               return DropdownMenuItem<String>(
                          //                 child: Text(dis),
                          //                 value: dis,
                          //               );
                          //             }).toList(),
                          //             onChanged: (newValue) {
                          //               print("Department: $newValue");
                          //               setState(() {
                          //                 if (newValue ==
                          //                     "Show on particular day") {
                          //                   isRepeat = "no";
                          //                 } else
                          //                   isRepeat = "yes";
                          //               });
                          //               // print("Department Id: $dep");
                          //             },
                          //           ),
                          //         ),
                          //       )
                          //     : Container(),
                          (isRepeat == "yes")
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                      // color: Colors.black12,
                                      // border: Border(
                                      //   bottom: BorderSide(
                                      //       color: Colors.black12, width: 2),
                                      // ),
                                      ),
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       child: Icon(
                                      //         Icons.repeat,
                                      //         color: Colors.blueGrey[800],
                                      //         size: 20,
                                      //       ),
                                      //     ),
                                      //     SizedBox(width: 10),
                                      //     Text(
                                      //       "Repeat",
                                      //       style: TextStyle(
                                      //         fontSize: 12,
                                      //         color: Colors.blueGrey[800],
                                      //         fontWeight: FontWeight.w400,
                                      //       ),
                                      //     ),
                                      //     SizedBox(width: 10),
                                      //     Text(
                                      //       "Daily",
                                      //       style: TextStyle(
                                      //         fontSize: 16,
                                      //         color: Color.fromRGBO(120, 218, 243, 1),
                                      //         fontWeight: FontWeight.w500,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Monday
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isClickDays[0] =
                                                    !isClickDays[0];
                                                if (isClickDays[0] == true) {
                                                  weekDays[0] = "1";
                                                } else {
                                                  weekDays[0] = "0";
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: isClickDays[0]
                                                    ? Colors.red
                                                    : Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "M",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Tuesday
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isClickDays[1] =
                                                    !isClickDays[1];
                                                if (isClickDays[1] == true) {
                                                  weekDays[1] = "1";
                                                } else {
                                                  weekDays[1] = "0";
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: isClickDays[1]
                                                    ? Colors.red
                                                    : Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "T",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Wednesday
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isClickDays[2] =
                                                    !isClickDays[2];
                                                if (isClickDays[2] == true) {
                                                  weekDays[2] = "1";
                                                } else {
                                                  weekDays[2] = "0";
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: isClickDays[2]
                                                    ? Colors.red
                                                    : Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "W",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Thursday
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isClickDays[3] =
                                                    !isClickDays[3];
                                                if (isClickDays[3] == true) {
                                                  weekDays[3] = "1";
                                                } else {
                                                  weekDays[3] = "0";
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: isClickDays[3]
                                                    ? Colors.red
                                                    : Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "T",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Friday
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isClickDays[4] =
                                                    !isClickDays[4];
                                                if (isClickDays[4] == true) {
                                                  weekDays[4] = "1";
                                                } else {
                                                  weekDays[4] = "0";
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: isClickDays[4]
                                                    ? Colors.red
                                                    : Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "F",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Saturday
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isClickDays[5] =
                                                    !isClickDays[5];
                                                if (isClickDays[5] == true) {
                                                  weekDays[5] = "1";
                                                } else {
                                                  weekDays[5] = "0";
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: isClickDays[5]
                                                    ? Colors.red
                                                    : Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "S",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Sunday
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isClickDays[6] =
                                                    !isClickDays[6];
                                                if (isClickDays[6] == true) {
                                                  weekDays[6] = "1";
                                                } else {
                                                  weekDays[6] = "0";
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: isClickDays[6]
                                                    ? Colors.red
                                                    : Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "S",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    Languages.of(context).upPic,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: selectphoto
                                              ? DecorationImage(
                                                  image: FileImage(image),
                                                  fit: BoxFit.cover,
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
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  if (dishName == null || dishName == "") {
                                    field1 = true;
                                  } else if (descrption == null ||
                                      descrption == "") {
                                    field2 = true;
                                  } else if (fullprice == null ||
                                      fullprice == "") {
                                    field3 = true;
                                  } else if (halfprice == null ||
                                      halfprice == "") {
                                    field4 = true;
                                  } else if (maxQuantity == null ||
                                      maxQuantity == "") {
                                    field5 = true;
                                  }
                                });
                                if (dishName == null || dishName == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Enter Dish Name",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (descrption == null ||
                                    descrption == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Enter Description",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (foodQuan == null || foodQuan == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Select Food Quantity",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (fullprice == null ||
                                    fullprice == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Enter price",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (halfprice == null ||
                                    halfprice == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Enter price",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (categoryNumber == null ||
                                    categoryNumber == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Select Category",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (maxQuantity == null ||
                                    maxQuantity == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Enter Maximum Quantity",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else if (photoUpload == null ||
                                    photoUpload == "") {
                                  Flushbar(
                                    //flushbarStyle: FlushbarStyle.GROUNDED,
                                    icon: Icon(Icons.error),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    title: "Error",
                                    message: "Upload Dish Image",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  getAddMenuData(
                                    dishName,
                                    descrption,
                                    fullprice,
                                    halfprice,
                                    widget.userId,
                                    foodQuan,
                                    categoryNumber,
                                    maxQuantity,
                                    photoUpload,
                                    videoUpload,
                                    selectedDate,
                                    weekDays,
                                  ).then((value) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          // insetAnimationCurve:
                                          //     Curves.bounceIn,
                                          child: Container(
                                            height: 350,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                            ),
                                            child: Column(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Transform.translate(
                                                    offset:
                                                        const Offset(15, -15),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        // Navigator
                                                        //     .pushReplacement(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         KitchenDashboard(),
                                                        //   ),
                                                        // );
                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color.fromRGBO(
                                                                    224,
                                                                    74,
                                                                    34,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    219,
                                                                    47,
                                                                    35,
                                                                    1)
                                                              ],
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .close_rounded,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    'assets/svg/Group 2017.svg'),
                                                const SizedBox(height: 20),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  //color: Colors.black12,
                                                  height: 40,
                                                  child: Text(
                                                    Languages.of(context)
                                                        .addMenuSuccess,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddSpecialItemScreen(
                                                                widget.userId,
                                                                widget
                                                                    .kitchenName,
                                                                widget.email,
                                                                widget.logo),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    child: Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Color.fromRGBO(
                                                                  224,
                                                                  74,
                                                                  34,
                                                                  1),
                                                              Color.fromRGBO(
                                                                  219,
                                                                  47,
                                                                  35,
                                                                  1)
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                Languages.of(
                                                                        context)
                                                                    .addMore,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .add_circle_outline,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                                }
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
                                  Languages.of(context).submit,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _isLoading ? loader(context) : Container(),
          ],
        ),
      ),
    );
  }
}
