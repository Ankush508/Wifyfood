import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForOrderCancel {
  int status;
  String message;

  ResForOrderCancel({
    this.status,
    this.message,
  });

  factory ResForOrderCancel.fromJson(Map<String, dynamic> json) {
    return ResForOrderCancel(
      status: json['status'],
      message: json['message'],
      // response: Response.fromJson(json['RESPONSE']),
    );
  }
}

Future<ResForOrderCancel> getOrderCancelData(String orderId) async {
  print("Order Id: $orderId");
  // print("Status: $status");
  var link = Uri.parse("https://wifyfood.com/api/users/ordercancel");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "order_id": orderId,
          "status": "5",
        },
      ));
  //print('Response: ${res.body}');
  //print(res.body.length);
  if (res.statusCode == 200) {
    if (res.body.length < 100) {
      return ResForOrderCancel();
    } else {
      return ResForOrderCancel.fromJson(jsonDecode(res.body));
    }
  } else {
    print('Exit');
    return null;
  }
}
