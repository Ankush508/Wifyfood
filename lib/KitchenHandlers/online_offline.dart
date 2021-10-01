import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForOnlineOffline {
  int status;
  String message;

  ResForOnlineOffline({
    this.status,
    this.message,
  });

  factory ResForOnlineOffline.fromJson(Map<String, dynamic> json) {
    return ResForOnlineOffline(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForOnlineOffline> getOnlineOfflineData(
  String kitchenId,
  int status,
) async {
  print("Kitchen Id: $kitchenId");
  print("Status: $status");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/onlineoffline");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "kitchen_id": kitchenId,
          "status": status,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForOnlineOffline.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForOnlineOffline();
    }
  } else {
    print('Exit');
    return null;
  }
}
