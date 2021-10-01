import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForMyAccount {
  int status;
  String message;

  ResForMyAccount({
    this.status,
    this.message,
  });

  factory ResForMyAccount.fromJson(Map<String, dynamic> json) {
    return ResForMyAccount(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForMyAccount> getMyAccount(
  String uid,
  String fName,
  String lName,
  String email,
  //String pw,
  String profilePic,
) async {
  var link = Uri.parse("https://wifyfood.com/api/users/myacount");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "user_id": uid,
          "f_name": fName,
          "l_name": lName,
          "email": email,
          "password": " ",
          "image": profilePic,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForMyAccount.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
