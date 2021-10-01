import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForOrderStatus {
  int status;
  String message;

  ResForOrderStatus({
    this.status,
    this.message,
  });

  factory ResForOrderStatus.fromJson(Map<String, dynamic> json) {
    return ResForOrderStatus(
      status: json['status'],
      message: json['message'],
      // response: Response.fromJson(json['RESPONSE']),
    );
  }
}

Future<ResForOrderStatus> getOrderStatusData(
    String orderId, String status) async {
  print("Order Id: $orderId");
  print("Status: $status");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/orderstatus");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "order_id": orderId,
          "status": status,
        },
      ));
  //print('Response: ${res.body}');
  //print(res.body.length);
  if (res.statusCode == 200) {
    try {
      if (res.body.length < 100) {
        return ResForOrderStatus();
      } else {
        return ResForOrderStatus.fromJson(jsonDecode(res.body));
      }
    } catch (e) {
      return ResForOrderStatus();
    }
  } else {
    print('Exit');
    return null;
  }
}
