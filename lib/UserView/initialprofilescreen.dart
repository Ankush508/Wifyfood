import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/user_profile.dart';
import 'package:wifyfood/UserHandlers/myaccount.dart';
import 'package:wifyfood/UserView/homescreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wifyfood/UserView/userdashboard.dart';

class InitialProfileScreen extends StatefulWidget {
  final String userId;

  InitialProfileScreen(this.userId);
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<InitialProfileScreen> {
  var res;
  bool isLoading = true;
  bool selectPic = false;
  String fName;
  String lName;
  String email;
  String pw;
  //bool isEdit = false;
  String logo = "";
  File image;
  File croppedImage;
  PickedFile imageFile;
  final _picker = ImagePicker();
  final _formKey = new GlobalKey<FormState>();
  bool field1 = false, field2 = false, field3 = false;

  Future getImage() async {
    // final pickedFile = await _picker.getImage(
    //   source: ImageSource.gallery,
    // );
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _cropImage(pickedFile.path);
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
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Edit Profile Pic",
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

      selectPic = true;
    });
  }

  @override
  void initState() {
    getProfileData(widget.userId).then((value) {
      setState(() {
        res = value.response;
        //print('Res: $res');
        isLoading = false;
      });
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
          'My Account',
          style: TextStyle(),
        ),
        actions: [],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            BackgroundScreen(),
            BackgroundCircle(),
            isLoading
                ? Container(
                    child: Center(
                      child: RefreshProgressIndicator(),
                    ),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        selectPic ? FileImage(image) : null,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color.fromRGBO(224, 74, 34, 1),
                                                Color.fromRGBO(219, 47, 35, 1)
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        Image.asset(
                                            'assets/Icon feather-camera.png')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.5,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextFormField(
                                    initialValue: '${res.firstName}',
                                    validator: (value) {
                                      if (field1 == true) {
                                        return 'Enter First Name*';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      border: InputBorder.none,
                                      labelText: 'First Name',
                                      labelStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      //hintText: "Pepe's Restaurant",
                                      hintStyle: TextStyle(
                                        //fontSize: 18,
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      fName = value;
                                      setState(() {
                                        if (value.isEmpty) {
                                          field1 = true;
                                        } else
                                          field1 = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.5,
                                        color: Colors.red,
                                        // : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextFormField(
                                    //enabled: isEdit ? true : false,
                                    initialValue: '${res.lastName}',
                                    validator: (value) {
                                      if (field2 == true) {
                                        return 'Enter Last Name*';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      border: InputBorder.none,
                                      labelText: 'Last Name',
                                      labelStyle:
                                          TextStyle(color: Colors.grey[700]),
                                      hintStyle: TextStyle(
                                        //fontSize: 18,
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      lName = value;
                                      setState(() {
                                        if (value.isEmpty) {
                                          field2 = true;
                                        } else
                                          field2 = false;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.5,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                //enabled: isEdit ? true : false,
                                initialValue: '${res.mobileNumber}',
                                validator: (value) {
                                  if (field3 == true) {
                                    return 'Enter Mobile Number*';
                                  } else if (value.length == 0) {
                                    return null;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  border: InputBorder.none,
                                  labelText: 'Mobile No',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[800]),
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.5,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                //enabled: isEdit ? true : false,
                                //initialValue: '${res.email}',
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
                                  labelText: 'Email Id',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[800]),
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onChanged: (value) {
                                  email = value;
                                },
                              ),
                            ),
                            SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    if (fName == null || fName == "") {
                                      field1 = true;
                                    } else if (lName == null || lName == "") {
                                      field2 = true;
                                    }
                                  });
                                  // if (logo == "") {
                                  //   Flushbar(
                                  //     //flushbarStyle: FlushbarStyle.GROUNDED,
                                  //     icon: Icon(Icons.error),
                                  //     flushbarPosition: FlushbarPosition.TOP,
                                  //     title: "Error",
                                  //     message: "Please Select Profile Image",
                                  //     duration: Duration(seconds: 5),
                                  //     backgroundColor: Colors.red,
                                  //   ).show(context);
                                  // } else {
                                  Geolocator.isLocationServiceEnabled()
                                      .then((value) {
                                    if (value == false) {
                                      Geolocator.requestPermission();
                                      Fluttertoast.showToast(
                                        msg: "Turn on your GPS",
                                        fontSize: 20,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    } else {
                                      getMyAccount(widget.userId, fName, lName,
                                              email, logo)
                                          .then((value) {
                                        Fluttertoast.showToast(
                                          msg: "Profile Saved",
                                          fontSize: 20,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.blue,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => /*HomeScreen(),*/ UserDashboardScreen(
                                                    widget.userId),
                                          ),
                                        );
                                      });
                                    }
                                  });
                                  // }
                                }
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
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
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
      // bottomNavigationBar: BottomBar(widget.string1, widget.string2,
      //     widget.string3, widget.string4, widget.userId),
    );
  }
}
