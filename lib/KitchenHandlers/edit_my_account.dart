import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForEditMyAccount {
  int status;
  String message;

  ResForEditMyAccount({
    this.status,
    this.message,
  });

  factory ResForEditMyAccount.fromJson(Map<String, dynamic> json) {
    return ResForEditMyAccount(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForEditMyAccount> getMyAccount(
  String id,
  ownName,
  dob,
  kitchenName,
  cuisine,
  email,
  location,
  lat,
  long,
  pincode,
  devId,
  mob,
  logo,
  pass,
  state,
  city,
) async {
  print("Kitchen Id: $id");
  print("Owner Name: $ownName");
  print("DoB: $dob");
  print("Kitchen Name: $kitchenName");
  print("Cuisine: $cuisine");
  print("Email: $email");
  print("Location: $location");
  print("Latitude: $lat");
  print("Longitude: $long");
  print("Pincode: $pincode");
  print("Device Id: $devId");
  print("Mobile: $mob");
  print("Logo: ${logo.length}");
  print("Password: $pass");
  print("State: $state");
  print("City: $city");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/myacount");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "id": id,
          "owner_name": ownName,
          "owner_dob": dob,
          "kitchen_name": kitchenName,
          "cuisine": cuisine,
          "email": email,
          "location": location,
          "latitude": lat,
          "longitude": long,
          "pincode": pincode,
          "device_id": devId,
          "mobile": mob,
          "logo": logo,
          "password": pass,
          "state": state,
          "city": city
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForEditMyAccount.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForEditMyAccount();
    }
  } else {
    print('Exit');
    return null;
  }
}
