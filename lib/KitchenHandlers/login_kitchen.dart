import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForLoginKitchen {
  int status;
  String message;
  User user;

  ResForLoginKitchen({
    this.status,
    this.message,
    this.user,
  });

  factory ResForLoginKitchen.fromJson(Map<String, dynamic> json) {
    return ResForLoginKitchen(
      status: json['status'],
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  String userId;
  String ownerName;
  String dob;
  String kitchenName;
  String cuisine;
  String email;
  String location;
  String latitude;
  String longitude;
  String pincode;
  String mobile;
  String logo;
  String otp;
  String password;
  String deviceId;
  String status;

  User({
    this.userId,
    this.ownerName,
    this.dob,
    this.kitchenName,
    this.cuisine,
    this.email,
    this.location,
    this.latitude,
    this.longitude,
    this.pincode,
    this.mobile,
    this.logo,
    this.otp,
    this.password,
    this.deviceId,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      ownerName: json['owner_name'],
      dob: json['owner_dob'],
      kitchenName: json['kitchen_name'],
      cuisine: json['cuisine'],
      email: json['email'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      pincode: json['pincode'],
      mobile: json['mobile'],
      logo: json['logo'],
      otp: json['otp'],
      password: json['password'],
      deviceId: json['device_id'],
      status: json['status'],
    );
  }
}

Future<ResForLoginKitchen> getLoginKitchen(
    String mobile, String wifyId, String pass, String devId) async {
  print("Mobile: $mobile");
  print("Wify Id: $wifyId");
  print("Password: $pass");
  print("Device Id: $devId");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/login");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "id": "1",
          "WifyfoodId": wifyId, //123456,
          "mobile": mobile,
          "password": pass, //123456,
          "device_id": devId,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForLoginKitchen.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForLoginKitchen();
    }
  } else {
    print('Exit');
    return null;
  }
}
