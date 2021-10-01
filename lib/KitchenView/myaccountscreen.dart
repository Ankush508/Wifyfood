import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wifyfood/Helper/custom_widgets.dart';
import 'package:wifyfood/KitchenHandlers/kitchen_profile.dart';
import 'package:wifyfood/KitchenHandlers/edit_my_account.dart';
import 'package:wifyfood/KitchenView/kitchendashboard.dart';
import 'package:wifyfood/Language/text_keys.dart';

class MyAccountScreen extends StatefulWidget {
  final String kitchenId;
  MyAccountScreen(this.kitchenId);
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String ownName;
  String dob;
  String kitchenName;
  String cuisine;
  String email;
  String location;
  String latitude;
  String longitude;
  String pincode;
  String deviceId;
  String mobile;
  String logo;
  String password;
  String des;
  String state;
  String city;
  bool isEdit = false;
  bool isLoading = true;
  bool _obscureText = true;
  bool field1 = false,
      field2 = false,
      field3 = false,
      field4 = false,
      field5 = false;

  final _formKey = new GlobalKey<FormState>();

  final _picker = ImagePicker();

  File image;
  bool selectphoto = false;

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
      logo = base64Image;
      selectphoto = true;
    });
  }

  Widget kitchenLogo(String logo) {
    logo = base64.normalize(logo);
    Uint8List bytes;
    setState(() {
      bytes = base64Decode(logo);
    });

    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          image: selectphoto ? FileImage(image) : MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ResForKitchenProfile res;
  @override
  void initState() {
    getKitchenProfileData(widget.kitchenId).then((value) {
      res = value;
      setState(() {
        isLoading = false;
        ownName = res.response.ownerName;
        dob = res.response.dob;
        kitchenName = res.response.kitchenName;
        cuisine = res.response.cuisine;
        email = res.response.email;
        location = res.response.location;
        latitude = res.response.latitude;
        longitude = res.response.longitude;
        pincode = res.response.pincode;
        deviceId = res.response.deviceId;
        mobile = res.response.mobile;
        password = res.response.password;
        city = res.response.city;
      });
    });
    // PushNotification().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KitchenDashboard(),
          ),
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.grey[700]),
          centerTitle: true,
          title: Text(
            Languages.of(context).myAcc,
            style: TextStyle(
                //color: Colors.grey[700],
                ),
          ),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  isEdit = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    (res.response.logo == "")
                                        ? selectphoto
                                            ? Container(
                                                height: 140,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                    image: FileImage(image),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: 140,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  // image: DecorationImage(
                                                  //   image: FileImage(image),
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ),
                                              )
                                        : kitchenLogo(res.response.logo),
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
                                                  getImage().then((value) {
                                                    // setState(() {
                                                    //   selectphoto = true;
                                                    // });
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.red[600],
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
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
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  '${res.response.kitchenName}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${res.response.email}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                enabled: isEdit ? true : false,
                                initialValue: "${res.response.kitchenName}",
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: Languages.of(context).kitName,

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
                                  setState(() {
                                    ownName = value;
                                  });
                                },
                              ),
                              TextFormField(
                                enabled: isEdit ? true : false,
                                initialValue: '${res.response.mobile}',
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: Languages.of(context).mobNo,
                                  labelStyle:
                                      TextStyle(color: Colors.grey[800]),
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    mobile = value;
                                  });
                                },
                              ),
                              TextFormField(
                                enabled: isEdit ? true : false,
                                initialValue: '${res.response.email}',
                                validator: (value) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (value.isEmpty) {
                                    return null;
                                  } else if (!regex.hasMatch(value)) {
                                    return 'Please enter a valid email id';
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: Languages.of(context).email,
                                  labelStyle:
                                      TextStyle(color: Colors.grey[800]),
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                              TextFormField(
                                enabled: isEdit ? true : false,
                                initialValue: '${res.response.password}',
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: Languages.of(context).changePass,
                                  labelStyle:
                                      TextStyle(color: Colors.grey[800]),
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  suffix: isEdit
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                          child: _obscureText
                                              ? Icon(
                                                  Icons.lock,
                                                  size: 20,
                                                  color: Colors.grey[700],
                                                )
                                              : Icon(
                                                  Icons.lock_open,
                                                  size: 20,
                                                  color: Colors.grey[700],
                                                ),
                                        )
                                      : Container(
                                          height: 20,
                                          width: 5,
                                        ),
                                ),
                                onChanged: (value) {
                                  password = value;
                                },
                              ),
                              TextFormField(
                                enabled: isEdit ? true : false,
                                initialValue: "${res.response.des}",
                                // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took",
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: Languages.of(context).about,
                                  labelStyle:
                                      TextStyle(color: Colors.grey[800]),
                                  hintStyle: TextStyle(
                                    //fontSize: 18,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    des = value;
                                  });
                                },
                                maxLines: 5,
                              ),
                              SizedBox(height: 15),
                              Divider(
                                color: Colors.red,
                                thickness: 1.5,
                              ),
                              SizedBox(height: 30),
                              isEdit
                                  ? GestureDetector(
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          getMyAccount(
                                                  widget.kitchenId,
                                                  ownName,
                                                  dob,
                                                  kitchenName,
                                                  cuisine,
                                                  email,
                                                  location,
                                                  latitude,
                                                  longitude,
                                                  pincode,
                                                  deviceId,
                                                  mobile,
                                                  logo,
                                                  password,
                                                  "",
                                                  city)
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
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(28, 149, 71, 1),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            Languages.of(context).save,
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
      ),
    );
  }
}
