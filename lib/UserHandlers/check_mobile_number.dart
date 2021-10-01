import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForCheckMobile {
  int resCode;
  String mobile;
  String response;
  int otp;

  ResForCheckMobile({
    this.resCode,
    this.mobile,
    this.response,
    this.otp,
  });

  factory ResForCheckMobile.fromJson(Map<String, dynamic> json) {
    return ResForCheckMobile(
      resCode: json['RESPONSECODE'],
      mobile: json['mobile'],
      response: json['RSPONSE'],
      otp: json['otp'],
    );
  }
}

Future<ResForCheckMobile> getMobileData(
    String mob, String devId, String lat, String long) async {
  print("Mobile: $mob");
  print("Device Id: $devId");
  print("Latitude: $lat");
  print("Longitude: $long");
  var link = Uri.parse("https://wifyfood.com/api/users/checkmobile");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'mobile': mob,
          'device_id': devId,
          'latitude': lat,
          'longitude': long,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForCheckMobile.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
