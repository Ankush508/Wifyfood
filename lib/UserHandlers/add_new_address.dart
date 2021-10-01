import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForAddAddress {
  int status;
  String message;

  ResForAddAddress({
    this.status,
    this.message,
  });

  factory ResForAddAddress.fromJson(Map<String, dynamic> json) {
    return ResForAddAddress(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForAddAddress> getAddAddress(
    String uid,
    String location,
    String address,
    String landmark,
    String addType,
    String lat,
    String long) async {
  print("User Id: $uid");
  print("Add Type: $addType");
  print("Address: $address");
  print("Location: $location");
  print("Landmark: $landmark");
  print("Latitude: $lat");
  print("Longitude: $long");
  var link = Uri.parse("https://wifyfood.com/api/users/addaddress");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'user_id': uid,
          'location': location,
          'latitude': lat,
          'longitude': long,
          'address': address,
          'landmark': landmark,
          'addresstype': addType,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForAddAddress.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
