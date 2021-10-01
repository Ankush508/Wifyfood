import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForResendOtp {
  int responseCode;
  String mobile;
  String response;
  int otp;

  ResForResendOtp({
    this.responseCode,
    this.mobile,
    this.response,
    this.otp,
  });

  factory ResForResendOtp.fromJson(Map<String, dynamic> json) {
    return ResForResendOtp(
      responseCode: json['RESPONSECODE'],
      mobile: json['mobile'],
      response: json['RESPONSE'],
      otp: json['otp'],
    );
  }
}

Future<ResForResendOtp> getResendOtpData(String mobile) async {
  //print("Mobile: $mob");
  var link = Uri.parse("https://wifyfood.com/api/users/resendotp");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'mobile': mobile,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForResendOtp.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
