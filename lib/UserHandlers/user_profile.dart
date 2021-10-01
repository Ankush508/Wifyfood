import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForUserProfile {
  int responseCode;
  Response response;

  ResForUserProfile({
    this.responseCode,
    this.response,
  });

  factory ResForUserProfile.fromJson(Map<String, dynamic> json) {
    return ResForUserProfile(
      responseCode: json['RESPONSECODE'],
      response: Response.fromJson(json['RESPONSE']),
    );
  }
}

class Response {
  String userId;
  String firstName;
  String lastName;
  String image;
  String email;
  String password;
  String mobileNumber;

  Response({
    this.userId,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.password,
    this.mobileNumber,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      userId: json['id'],
      firstName: json['f_name'],
      lastName: json['l_name'],
      image: json['image'],
      email: json['email'],
      password: json['password'],
      mobileNumber: json['mobile'],
    );
  }
}

Future<ResForUserProfile> getProfileData(String uid) async {
  print("uid profile: $uid");
  var link = Uri.parse("https://wifyfood.com/api/users/userprofile/$uid");
  http.Response res = await http.get(
    link,
  );
  print('Response of Profile Data: ${res.body}');
  if (res.statusCode == 200) {
    return ResForUserProfile.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
