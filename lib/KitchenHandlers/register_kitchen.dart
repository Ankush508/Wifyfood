import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForRegisterKitchen {
  int resCode;
  String mobile;
  String response;
  int otp;

  ResForRegisterKitchen({
    this.resCode,
    this.mobile,
    this.response,
    this.otp,
  });

  factory ResForRegisterKitchen.fromJson(Map<String, dynamic> json) {
    return ResForRegisterKitchen(
      resCode: json['RESPONSECODE'],
      mobile: json['mobile'],
      response: json['RESPONSE'],
      otp: json['otp'],
    );
  }
}

Future<ResForRegisterKitchen> getRegisterKitchen(
    String ownName,
    String dob,
    String kitchenName,
    String cuisine,
    String email,
    String location,
    String latitude,
    String longitude,
    String pincode,
    String description,
    String deviceId,
    String mob,
    String pw,
    String logo,
    String city,
    String state) async {
  print("Name: $ownName");
  print("DateOfBirth: $dob");
  print("Kitchen Name: $kitchenName");
  print("Cuisine: $cuisine");
  print("Email: $email");
  print("Location: $location");
  print("Latitude: $latitude");
  print("Longitude: $longitude");
  print("Pincode: $pincode");
  print("Device Id: $deviceId");
  print("Mobile: $mob");
  print("Password: $pw");
  print("Description: $description");
  print("City Id: $city");
  print("State: $state");
  //print("Logo: $logo");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/registration");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "owner_name": ownName,
          "owner_dob": dob,
          "kitchen_name": kitchenName,
          "cuisine": cuisine,
          "email": email,
          "location": location,
          "latitude": latitude,
          "longitude": longitude,
          "pincode": pincode,
          "device_id": deviceId,
          "mobile": mob,
          "password": pw,
          "logo": logo,
          "description": description,
          "city": city,
          "state": state,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForRegisterKitchen.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForRegisterKitchen();
    }
  } else {
    print('Exit');
    return null;
  }
}
