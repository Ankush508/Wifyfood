import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForForgotCheckMobile {
  int resCode;
  String mobile;
  String response;
  int otp;

  ResForForgotCheckMobile({
    this.resCode,
    this.mobile,
    this.response,
    this.otp,
  });

  factory ResForForgotCheckMobile.fromJson(Map<String, dynamic> json) {
    return ResForForgotCheckMobile(
      resCode: json['RESPONSECODE'],
      mobile: json['mobile'],
      response: json['RESPONSE'],
      otp: json['otp'],
    );
  }
}

Future<ResForForgotCheckMobile> getForgotCheckMobileData(String mobile) async {
  //print("Mobile: $mob");
  print("Mobile: $mobile");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/forgot_checkmobile");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "mobile": mobile,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForForgotCheckMobile.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForForgotCheckMobile();
    }
  } else {
    print('Exit');
    return null;
  }
}
