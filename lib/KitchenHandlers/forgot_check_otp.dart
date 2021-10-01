import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForForgotCheckOtp {
  int status;
  String message;
  String response;

  ResForForgotCheckOtp({
    this.status,
    this.message,
    this.response,
  });

  factory ResForForgotCheckOtp.fromJson(Map<String, dynamic> json) {
    return ResForForgotCheckOtp(
      status: json['status'],
      message: json['message'],
      response: json['response'],
    );
  }
}

class Response {
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
  String deviceId;
  String status;

  Response({
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
    this.deviceId,
    this.status,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
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
      deviceId: json['device_id'],
      status: json['status'],
    );
  }
}

Future<ResForForgotCheckOtp> getForgotCheckOtpData(
    String mob, String otpNum) async {
  //print("Mobile: $mob");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/forgot_checkotp");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'mobile': mob,
          'otp': otpNum,
        },
      ));
  print('Response: ${res.body}');
  print(res.body.length);
  if (res.statusCode == 200) {
    try {
      return ResForForgotCheckOtp.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForForgotCheckOtp();
    }
  } else {
    print('Exit');
    return null;
  }
}
