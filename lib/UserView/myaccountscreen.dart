import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wifyfood/Helper/bottom_navigation_bar.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/UserHandlers/myaccount.dart';
import 'package:wifyfood/UserHandlers/user_profile.dart';

class MyAccountScreen extends StatefulWidget {
  final String userId, cityId;
  final List<String> address;

  MyAccountScreen(this.userId, this.address, this.cityId);
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String string1,
      string2,
      string3,
      string4,
      string5,
      fName,
      lName,
      email,
      profilePic;
  var res;
  bool isLoading = true;
  bool isEdit = false;
  final _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    string1 = 'assets/svg/Icon feather-home.svg';
    string2 = 'assets/svg/blog.svg';
    string3 = 'assets/svg/register kitchen.svg';
    string4 = 'assets/svg/Icon feather-user-1.svg';
    string5 = 'assets/svg/Tracking.svg';
    print("### User Id on my account screen: ${widget.userId}");
    getProfileData(widget.userId).then((value) {
      res = value.response;
      //print('Res: $res');
      setState(() {
        isLoading = false;
        fName = res.firstName;
        lName = res.lastName;
        email = res.email;
        profilePic = res.image;
      });
    });
    // PushNotification().initialize();
    super.initState();
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
  File image;
  bool selectphoto = false;
  String logo;
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
      profilePic = base64Image;
      selectphoto = true;
    });
  }

  Widget profileImage(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    bytes = base64Decode(logo);

    // return Material(
    //   elevation: 5,
    //   borderRadius: BorderRadius.circular(100),
    //   child: CircleAvatar(
    //     radius: 65,
    //     backgroundColor: Colors.white,
    //     backgroundImage: MemoryImage(bytes),
    //   ),
    // );
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          image: selectphoto ? FileImage(image) : MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
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
          'My Account',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  isEdit = true;
                });
              },
              child: isEdit
                  ? Icon(
                      Icons.edit,
                      color: Colors.red,
                    )
                  : Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        // ignore: deprecated_member_use
        autovalidate: true,
        child: Stack(
          children: [
            BackgroundScreen(),
            BackgroundCircle(),
            isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SafeArea(
                    //margin: EdgeInsets.only(top: 80),
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
                                  profileImage(res.image),
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          // color: Colors.red[600],
                                          color: Colors.red[50],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      isEdit
                                          ? Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                // color: Colors.red[600],
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        224, 74, 34, 1),
                                                    Color.fromRGBO(
                                                        219, 47, 35, 1)
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            )
                                          : Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                // color: Colors.red[600],
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                      Image.asset(
                                          'assets/Icon feather-camera.png'),
                                      isEdit
                                          ? GestureDetector(
                                              onTap: () {
                                                getImage();
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  // color: Colors.red[600],
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                // color: Colors.red[600],
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.5,
                                        color: isEdit
                                            ? Colors.red
                                            : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextFormField(
                                    enabled: isEdit ? true : false,
                                    initialValue: '${res.firstName}',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Required*';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'First Name',
                                      labelStyle:
                                          TextStyle(color: Colors.grey[700]),
                                      //hintText: "Pepe's Restaurant",
                                      hintStyle: TextStyle(
                                        //fontSize: 18,
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      fName = value;
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1.5,
                                        color: isEdit
                                            ? Colors.red
                                            : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextFormField(
                                    enabled: isEdit ? true : false,
                                    initialValue: '${res.lastName}',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Required*';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
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
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.5,
                                    color:
                                        isEdit ? Colors.red : Colors.grey[700],
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                enabled: isEdit ? true : false,
                                initialValue: '${res.mobileNumber}',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Required*';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Mobile No',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[700]),
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.5,
                                    color:
                                        isEdit ? Colors.red : Colors.grey[700],
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                enabled: isEdit ? true : false,
                                keyboardType: TextInputType.emailAddress,
                                initialValue: '${res.email}',
                                validator: (value) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (value.isEmpty) {
                                    return 'Required*';
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return 'Please enter a valid email id';
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Email Id',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[700]),
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
                            isEdit
                                ? GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        getMyAccount(widget.userId, fName,
                                                lName, email, profilePic)
                                            .then((value) {
                                          Fluttertoast.showToast(
                                            msg: "Profile Saved",
                                            fontSize: 20,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.blue,
                                            toastLength: Toast.LENGTH_LONG,
                                          );
                                          setState(() {
                                            isEdit = false;
                                          });
                                        });
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
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomBar(
      //     string1,
      //     string2,
      //     string3,
      //     string4,
      //     string5,
      //     widget.address,
      //     widget.cityId,
      //     [false, false, false, false, true]),
    );
  }
}
