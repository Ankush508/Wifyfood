import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForCheckOtp {
  int status;
  String message;
  Response response;

  ResForCheckOtp({
    this.status,
    this.message,
    this.response,
  });

  factory ResForCheckOtp.fromJson(Map<String, dynamic> json) {
    return ResForCheckOtp(
      status: json['status'],
      message: json['message'],
      response: Response.fromJson(json['RESPONSE']),
    );
  }
}

class Response {
  String userId;
  Response({
    this.userId,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      userId: json['id'],
      // firstName: json['f_name'],
      // lastName: json['l_name'],
      // image: json['image'],
      // email: json['email'],
      // password: json['password'],
      // mobileNumber: json['mobile'],
    );
  }
}

Future<ResForCheckOtp> getOtpData(String mob, String otpNum) async {
  print("Mobile: $mob");
  print("Otp: $otpNum");
  var link = Uri.parse("https://wifyfood.com/api/users/checkotp");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'mobile': mob,
          'otp': otpNum,
        },
      ));
  //var rest = res.body;
  //print('Rest: $rest');
  //print(rest.length);
  print("**************************");
  if (res.statusCode == 200) {
    try {
      var data = ResForCheckOtp.fromJson(jsonDecode(res.body));
      print("Response Data: $data");
      return data;
    } catch (e) {
      print("$e");
      return ResForCheckOtp();
    }
  } else {
    print('Exit');
    return null;
  }
}
