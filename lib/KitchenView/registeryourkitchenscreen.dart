import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/check_mobile.dart';
import 'package:wifyfood/KitchenView/addkitchenscreen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wifyfood/Language/text_keys.dart';
import 'package:wifyfood/UserHandlers/city_list.dart';

class RegisterYourKitchenScreen extends StatefulWidget {
  @override
  _RegisterYourKitchenScreenState createState() =>
      _RegisterYourKitchenScreenState();
}

class _RegisterYourKitchenScreenState extends State<RegisterYourKitchenScreen> {
  bool elev1 = false, elev2 = false, elev3 = false, elev4 = false;
  bool selectLogo = false;
  bool field1 = false,
      field2 = false,
      field3 = false,
      field4 = false,
      field5 = false;

  String ownerName;
  String dob;
  String kitchenName;
  String cuisine = "null";
  String email = "";
  String pincode;
  String mob;
  String password;
  String logo = "";
  bool _obscureText = true;
  List<City> cities = [];

  final _formKey = new GlobalKey<FormState>();

  DateTime date;
  File image;
  File croppedImage;
  PickedFile imageFile;
  TextEditingController _textEditingController = TextEditingController();

  Future<void> _selectDateOfBirth(BuildContext context) async {
    //final now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime(2001),
      firstDate: DateTime(1900), //now,
      lastDate: DateTime(2007),
    );
    if (picked != null && picked != date) {
      print("dob: $picked");
      setState(() {
        date = picked;
      });
    }
  }

  Future getImage() async {
    // var pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    // );
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _cropImage(pickedFile.path);
        // final File path = File(pickedFile.path);
        // _cropImageNew(path);
      } else {
        print('No image selected.');
      }
    });
  }

  _cropImage(filePath) async {
    croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      compressQuality: 10,
      //aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Edit Logo",
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
      logo = base64Image;
      selectLogo = true;
    });
  }

  @override
  void initState() {
    getCityListData().then((value) {
      cities = value;
    });
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
          Languages.of(context).reg,
          style: TextStyle(
              //color: Colors.grey,
              ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            BackgroundScreen(),
            BackgroundCircle(),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                            'assets/svg/Vector Smart Object-6.svg'),
                      ),
                      SizedBox(height: 30),
                      Text(
                        Languages.of(context).register,
                        style: TextStyle(
                            fontSize: 25,
                            //color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (field1 == true) {
                                  return 'Enter Your Name*';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).name,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  ownerName = value;
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
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
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
                                    DateFormat('dd/MM/yyyy').format(date);
                                dob = _textEditingController.text;
                                print(dob);
                                setState(() {
                                  if (_textEditingController.text.isEmpty) {
                                    field2 = true;
                                  } else
                                    field2 = false;
                                });
                              },
                              validator: (value) {
                                if (field2 == true) {
                                  return 'Select Your Date of Birth*';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).dob,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (field3 == true) {
                                  return 'Enter Name of the Kitchen*';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).kitchenName,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) async {
                                kitchenName = value;
                                if (value.isEmpty) {
                                  field3 = true;
                                } else
                                  field3 = false;
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("kitchen_name", value);
                                // await session.set("kitchen_name", value);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        Languages.of(context).cuisine,
                        style: TextStyle(
                            fontSize: 18,
                            //color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        // color: Colors.black12,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      elev1 = true;
                                      elev2 = false;
                                      elev3 = false;
                                      elev4 = false;
                                      cuisine = "veg";
                                    });
                                  },
                                  child: Material(
                                    elevation: elev1 ? 10 : 0,
                                    color: elev1
                                        ? Colors.green[800]
                                        : Colors.green[700],
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
                                          35,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: elev1
                                            ? Border.all(
                                                color: Colors.green[900],
                                                width: 5,
                                              )
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          Languages.of(context).veg,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      elev1 = false;
                                      elev2 = true;
                                      elev3 = false;
                                      elev4 = false;
                                      cuisine = "non-veg";
                                    });
                                  },
                                  child: Material(
                                    elevation: elev2 ? 10 : 0,
                                    color: elev2
                                        ? Colors.red[700]
                                        : Colors.red[600],
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
                                          35,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: elev2
                                            ? Border.all(
                                                color: Colors.red[900],
                                                width: 5,
                                              )
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          Languages.of(context).nonVeg,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       elev1 = false;
                                //       elev2 = false;
                                //       elev3 = true;
                                //       cuisine = "mixed";
                                //     });
                                //   },
                                //   child: Material(
                                //     elevation: elev3 ? 10 : 0,
                                //     color:
                                //         elev3 ? Colors.blue[800] : Colors.blue[700],
                                //     borderRadius: BorderRadius.circular(50),
                                //     child: Container(
                                //       width:
                                //           MediaQuery.of(context).size.width * 0.25,
                                //       height:
                                //           MediaQuery.of(context).size.height * 0.08,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(50),
                                //         border: elev3
                                //             ? Border.all(
                                //                 color: Colors.blue[900],
                                //                 width: 5,
                                //               )
                                //             : null,
                                //       ),
                                //       child: Center(
                                //         child: Text(
                                //           Languages.of(context).mixed,
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.w500),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       elev1 = true;
                                //       elev2 = false;
                                //       elev3 = false;
                                //       cuisine = "veg";
                                //     });
                                //   },
                                //   child: Material(
                                //     elevation: elev1 ? 10 : 0,
                                //     color: elev1
                                //         ? Colors.green[800]
                                //         : Colors.green[700],
                                //     borderRadius: BorderRadius.circular(50),
                                //     child: Container(
                                //       width:
                                //           MediaQuery.of(context).size.width * 0.22,
                                //       height:
                                //           MediaQuery.of(context).size.height * 0.08,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(50),
                                //         border: elev1
                                //             ? Border.all(
                                //                 color: Colors.green[900],
                                //                 width: 5,
                                //               )
                                //             : null,
                                //       ),
                                //       child: Center(
                                //         child: Text(
                                //           Languages.of(context).veg,
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.w500),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       elev1 = true;
                                //       elev2 = false;
                                //       elev3 = false;
                                //       cuisine = "veg";
                                //     });
                                //   },
                                //   child: Material(
                                //     elevation: elev1 ? 10 : 0,
                                //     color: elev1
                                //         ? Colors.green[800]
                                //         : Colors.green[700],
                                //     borderRadius: BorderRadius.circular(50),
                                //     child: Container(
                                //       width: MediaQuery.of(context).size.width *
                                //           0.22,
                                //       height:
                                //           MediaQuery.of(context).size.height *
                                //               0.08,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(50),
                                //         border: elev1
                                //             ? Border.all(
                                //                 color: Colors.green[900],
                                //                 width: 5,
                                //               )
                                //             : null,
                                //       ),
                                //       child: Center(
                                //         child: Text(
                                //           Languages.of(context).veg,
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.w500),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       elev1 = false;
                                //       elev2 = true;
                                //       elev3 = false;
                                //       cuisine = "non-veg";
                                //     });
                                //   },
                                //   child: Material(
                                //     elevation: elev2 ? 10 : 0,
                                //     color: elev2
                                //         ? Colors.red[700]
                                //         : Colors.red[600],
                                //     borderRadius: BorderRadius.circular(50),
                                //     child: Container(
                                //       width: MediaQuery.of(context).size.width *
                                //           0.25,
                                //       height:
                                //           MediaQuery.of(context).size.height *
                                //               0.08,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(50),
                                //         border: elev2
                                //             ? Border.all(
                                //                 color: Colors.red[900],
                                //                 width: 5,
                                //               )
                                //             : null,
                                //       ),
                                //       child: Center(
                                //         child: Text(
                                //           Languages.of(context).nonVeg,
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.w500),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      elev1 = false;
                                      elev2 = false;
                                      elev3 = true;
                                      elev4 = false;
                                      cuisine = "mixed";
                                    });
                                  },
                                  child: Material(
                                    elevation: elev3 ? 10 : 0,
                                    color: elev3
                                        ? Colors.blue[800]
                                        : Colors.blue[700],
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
                                          35,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: elev3
                                            ? Border.all(
                                                color: Colors.blue[900],
                                                width: 5,
                                              )
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          Languages.of(context).mixed,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      elev1 = false;
                                      elev2 = false;
                                      elev3 = false;
                                      elev4 = true;
                                      cuisine = "bakey";
                                    });
                                  },
                                  child: Material(
                                    elevation: elev4 ? 10 : 0,
                                    color: elev4
                                        ? Colors.deepOrange[600]
                                        : Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
                                          35,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: elev4
                                            ? Border.all(
                                                color: Colors.deepOrange[800],
                                                width: 5,
                                              )
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          Languages.of(context).bakery,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
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
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (value.isEmpty) {
                                  return null;
                                } else if (!regex.hasMatch(value)) {
                                  return 'Please enter a valid email id';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).email,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (field4 == true) {
                                  return 'Enter Mobile Number*';
                                } else if (value.length == 0) {
                                  return null;
                                } else if (value.length != 10) {
                                  return 'Enter Correct Mobile Number*';
                                }
                                return null;
                              },
                              //keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).mobNo,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                mob = value;
                                if (value.isEmpty) {
                                  field4 = true;
                                } else
                                  field4 = false;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: _obscureText,
                              validator: (value) {
                                if (field5 == true) {
                                  return 'Enter Password*';
                                }
                                return null;
                              },
                              textAlign: TextAlign.left,

                              //keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                border: InputBorder.none,
                                hintText: Languages.of(context).createPass,
                                hintStyle: TextStyle(
                                  //fontSize: 18,
                                  color: Colors.grey[700],

                                  // fontWeight: FontWeight.bold,
                                ),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: _obscureText
                                      ? Icon(
                                          Icons.lock,
                                          color: Colors.grey[700],
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.lock_open,
                                          color: Colors.grey[700],
                                          size: 20,
                                        ),
                                ),
                              ),
                              onChanged: (value) {
                                password = value;
                                if (value.isEmpty) {
                                  field5 = true;
                                } else
                                  field5 = false;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        Languages.of(context).addLogo,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          getImage();
                          setState(() {});
                        },
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          //color: Colors.white,
                          child: Container(
                            //padding: EdgeInsets.only(left: 20, right: 20),
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: selectLogo
                                  ? DecorationImage(
                                      image: FileImage(image),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                            ),
                            child: selectLogo
                                ? null
                                : Center(
                                    child: SvgPicture.asset(
                                        'assets/svg/Icon feather-image.svg'),
                                  ),
                          ),
                        ),
                      ),
                      // selectLogo
                      //     ? TextFormField(
                      //         initialValue: logo,
                      //         decoration: InputDecoration(),
                      //       )
                      //     : Container(),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              if (ownerName == null || ownerName == "") {
                                field1 = true;
                              } else if (dob == null || dob == "") {
                                field2 = true;
                              } else if (kitchenName == null ||
                                  kitchenName == "") {
                                field3 = true;
                              } else if (mob == null || mob == "") {
                                field4 = true;
                              } else if (password == null || password == "") {
                                field5 = true;
                              }
                            });
                            if (ownerName == null || ownerName == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Owner Name is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (dob == null) {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Select Date of Birth",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (kitchenName == null ||
                                kitchenName == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Kitchen Name is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (cuisine == "null") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Select Cuisine",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (mob == null || mob == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Mobile Number is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (password == null || password == "") {
                              Flushbar(
                                //flushbarStyle: FlushbarStyle.GROUNDED,
                                icon: Icon(Icons.error),
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Error",
                                message: "Password is required",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else {
                              getCheckMobileData(mob).then((value) {
                                if (value.status == 0) {
                                  Fluttertoast.showToast(
                                    msg:
                                        "This mobile number is already registered with us",
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddKitchenScreen(
                                        ownerName,
                                        dob,
                                        kitchenName,
                                        cuisine,
                                        email,
                                        mob,
                                        password,
                                        logo,
                                        cities,
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => AddKitchenScreen(
                            //         ownerName,
                            //         dob,
                            //         kitchenName,
                            //         cuisine,
                            //         email,
                            //         mob,
                            //         password,
                            //         logo),
                            //   ),
                            // );
                          }
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            // color: Colors.red[600],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(224, 74, 34, 1),
                                Color.fromRGBO(219, 47, 35, 1)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              Languages.of(context).submit,
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
            ),
          ],
        ),
      ),
    );
  }
}
