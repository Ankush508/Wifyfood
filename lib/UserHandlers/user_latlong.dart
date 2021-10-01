import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForUserLatLong {
  int status;
  String response;

  ResForUserLatLong({
    this.status,
    this.response,
  });

  factory ResForUserLatLong.fromJson(Map<String, dynamic> json) {
    return ResForUserLatLong(
      status: json['status'],
      response: json['response'],
    );
  }
}

Future<ResForUserLatLong> getUserLatLongData(
    String lat, String long, String userId) async {
  print("Updating User Latitude: $lat");
  print("Updating User Longitude: $long");
  print("User Id for Update LatLong: $userId");
  var link = Uri.parse("https://wifyfood.com/api/users/user_latlong");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "latitude": lat,
          "longitude": long,
          "id": userId,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForUserLatLong.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
