import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForOrderConfirm {
  int status;
  String response;
  OrderPlaced orderPlaced;

  ResForOrderConfirm({
    this.status,
    this.response,
    this.orderPlaced,
  });

  factory ResForOrderConfirm.fromJson(Map<String, dynamic> json) {
    return ResForOrderConfirm(
      status: json['status'],
      response: json['response'],
      orderPlaced: OrderPlaced.fromJson(json['orderplaced']),
    );
  }
}

class OrderPlaced {
  String addType;
  String address;
  String location;

  OrderPlaced({
    this.addType,
    this.address,
    this.location,
  });

  factory OrderPlaced.fromJson(Map<String, dynamic> json) {
    return OrderPlaced(
      addType: json['addresstype'],
      address: json['address'],
      location: json['location'],
    );
  }
}

Future<ResForOrderConfirm> getOrderConfirmData(String uid) async {
  print("uid: $uid");
  var link = Uri.parse("https://wifyfood.com/api/users/order_confirm/$uid");
  http.Response res = await http.get(
    link,
  );
  print('OrderPlaced of Profile Data: ${res.body}');
  if (res.statusCode == 200) {
    return ResForOrderConfirm.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
