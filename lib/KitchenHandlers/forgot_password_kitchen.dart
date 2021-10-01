import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForForgotPasswordKitchen {
  int resCode;
  String response;
  int otp;
  int password;

  ResForForgotPasswordKitchen({
    this.resCode,
    this.response,
    this.otp,
    this.password,
  });

  factory ResForForgotPasswordKitchen.fromJson(Map<String, dynamic> json) {
    return ResForForgotPasswordKitchen(
      resCode: json['RESPONSECODE'],
      response: json['RESPONSE'],
      otp: json['otp'],
      password: json['password'],
    );
  }
}

Future<ResForForgotPasswordKitchen> getForgotPasswordKitchen(
  String mob,
  pass1,
  pass2,
) async {
  print("Mobile: $mob");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/forgot_password");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "mobile": mob,
          "password": pass1,
          "confirm_password": pass2,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForForgotPasswordKitchen.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForForgotPasswordKitchen();
    }
  } else {
    print('Exit');
    return null;
  }
}
