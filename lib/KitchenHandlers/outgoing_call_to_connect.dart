import 'dart:convert';
import 'package:http/http.dart' as http;

class OutGoingCall {
  int status;
  // String message;
  // Response response;

  OutGoingCall({
    this.status,
    // this.message,
    // this.response,
  });

  // factory OutGoingCall.fromJson(Map<String, dynamic> json) {
  //   return OutGoingCall(
  //       // status: json['status'],
  //       // message: json['message'],
  //       // response: Response.fromJson(json['RESPONSE']),
  //       );
  // }
}

// class Response {
//   String userId;
//   String ownerName;
//   String dob;
//   String kitchenName;
//   String cuisine;
//   String email;
//   String location;
//   String latitude;
//   String longitude;
//   String pincode;
//   String mobile;
//   String logo;
//   String otp;
//   String deviceId;
//   String status;

//   Response({
//     this.userId,
//     this.ownerName,
//     this.dob,
//     this.kitchenName,
//     this.cuisine,
//     this.email,
//     this.location,
//     this.latitude,
//     this.longitude,
//     this.pincode,
//     this.mobile,
//     this.logo,
//     this.otp,
//     this.deviceId,
//     this.status,
//   });

//   factory Response.fromJson(Map<String, dynamic> json) {
//     return Response(
//       userId: json['id'],
//       ownerName: json['owner_name'],
//       dob: json['owner_dob'],
//       kitchenName: json['kitchen_name'],
//       cuisine: json['cuisine'],
//       email: json['email'],
//       location: json['location'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       pincode: json['pincode'],
//       mobile: json['mobile'],
//       logo: json['logo'],
//       otp: json['otp'],
//       deviceId: json['device_id'],
//       status: json['status'],
//     );
//   }
// }

Future<OutGoingCall> getOutgoingCallData(String from, to) async {
  print("From: $from");
  print("To: $to");
  String apiKey = "ffe9bba5496ebc01f874fef528f616b9f8945a8d38fde05a";
  String apiToken = "b08a4f7c4cd26fedd8bff3618c1665ffd83a672bcdfa7fda";
  String subDomain = "@api.exotel.com";
  String sid = "wifyfood1";
  var link = Uri.parse(
      "https://$apiKey:$apiToken$subDomain/v1/Accounts/$sid/Calls/connect");
  http.Response res = await http.post(link,
      // body: jsonEncode(
      //   {
      //     'mobile': mob,
      //     'otp': otpNum,
      //   },
      // )
      body: {
        'From': from,
        'To': to,
        'CallerId': "02248905414",
      });
  print('Response: ${res.body}');
  // print(res.body.length);
  if (res.statusCode == 200) {
    return OutGoingCall(status: 1);
  } else {
    print('Exit');
    return OutGoingCall(status: 0);
  }
}
