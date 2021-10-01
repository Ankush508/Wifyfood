import 'dart:convert';

import 'package:http/http.dart' as http;

class ResForRemoveAddress {
  int status;
  String data;

  ResForRemoveAddress({
    this.status,
    this.data,
  });

  factory ResForRemoveAddress.fromJson(Map<String, dynamic> json) {
    return ResForRemoveAddress(
      status: json['status'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
      };
}

Future<ResForRemoveAddress> getRemoveAddress(
    String userId, String addId) async {
  print(userId);
  var link =
      Uri.parse("https://wifyfood.com/api/users/removeaddress/$userId/$addId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForRemoveAddress.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
