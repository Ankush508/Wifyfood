import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForResendOtpKitchen {
  int responseCode;
  String mobile;
  String response;
  int otp;

  ResForResendOtpKitchen({
    this.responseCode,
    this.mobile,
    this.response,
    this.otp,
  });

  factory ResForResendOtpKitchen.fromJson(Map<String, dynamic> json) {
    return ResForResendOtpKitchen(
      responseCode: json['RESPONSECODE'],
      mobile: json['mobile'],
      response: json['RESPONSE'],
      otp: json['otp'],
    );
  }
}

Future<ResForResendOtpKitchen> getResendOtpKitchenData(String mobile) async {
  //print("Mobile: $mob");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/resendotp");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'mobile': mobile,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForResendOtpKitchen.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForResendOtpKitchen();
    }
  } else {
    print('Exit');
    return null;
  }
}
