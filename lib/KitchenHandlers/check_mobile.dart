import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForCheckMobile {
  int status;
  String message;

  ResForCheckMobile({
    this.status,
    this.message,
  });

  factory ResForCheckMobile.fromJson(Map<String, dynamic> json) {
    return ResForCheckMobile(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForCheckMobile> getCheckMobileData(String mobile) async {
  //print("Mobile: $mob");
  print("Mobile: $mobile");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/check_mobile");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "mobile": mobile,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForCheckMobile.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForCheckMobile();
    }
  } else {
    print('Exit');
    return null;
  }
}
