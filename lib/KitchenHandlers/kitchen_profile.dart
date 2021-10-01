import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForKitchenProfile {
  int responseCode;
  Response response;

  ResForKitchenProfile({
    this.responseCode,
    this.response,
  });

  factory ResForKitchenProfile.fromJson(Map<String, dynamic> json) {
    return ResForKitchenProfile(
      responseCode: json['RESPONSECODE'],
      response: Response.fromJson(json['RESPONSE']),
    );
  }
}

class Response {
  String id;
  String ownerName;
  String dob;
  String kitchenName;
  String cuisine;
  String des;
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
  String type;
  String onlineoffline;
  String city;

  Response({
    this.id,
    this.ownerName,
    this.dob,
    this.kitchenName,
    this.cuisine,
    this.des,
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
    this.type,
    this.onlineoffline,
    this.city,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['id'],
      ownerName: json['owner_name'],
      dob: json['owner_dob'],
      kitchenName: json['kitchen_name'],
      cuisine: json['cuisine'],
      des: json['description'],
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
      type: json['type'],
      onlineoffline: json['onlineoffline'],
      city: json['city'],
    );
  }
}

Future<ResForKitchenProfile> getKitchenProfileData(String kid) async {
  print("kid: $kid");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/kitchenprofile/$kid");
  http.Response res = await http.get(
    link,
  );
  //print('Response of Profile Data: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForKitchenProfile.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForKitchenProfile();
    }
  } else {
    print('Exit');
    return null;
  }
}
