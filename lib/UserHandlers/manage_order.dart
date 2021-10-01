import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForManageOrder> manageOrderListFromJson(String list) =>
    List<ResForManageOrder>.from(
      json.decode(list).map(
            (x) => ResForManageOrder.fromJson(x),
          ),
    );
String manageOrderListToJson(List<ResForManageOrder> list) => json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForManageOrder {
  int status;
  List<Order> order;

  ResForManageOrder({
    this.status,
    this.order,
  });

  factory ResForManageOrder.fromJson(Map<String, dynamic> json) {
    return ResForManageOrder(
      status: json['status'],
      order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
      };
}

class Order {
  String id;
  String userId;
  String delId;
  String kitchenId;
  String addId;
  String quantity;
  String price;
  String totalDiscount;
  String delCharge;
  String totPrice;
  String status;
  String dateTime;
  String payType;
  String kitchenName;
  String logo;
  String address;
  String location;

  Order({
    this.id,
    this.userId,
    this.delId,
    this.kitchenId,
    this.addId,
    this.quantity,
    this.price,
    this.totalDiscount,
    this.delCharge,
    this.totPrice,
    this.status,
    this.dateTime,
    this.payType,
    this.kitchenName,
    this.logo,
    this.address,
    this.location,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      delId: json['delivery_id'],
      kitchenId: json['kitchenid'],
      addId: json['address_id'],
      quantity: json['quantity'],
      price: json['price'],
      totalDiscount: json['total_discount'],
      delCharge: json['delivery_charge'],
      totPrice: json['total_price'],
      status: json['status'],
      dateTime: json['datetime'],
      payType: json['payment_type'],
      kitchenName: json['kitchen_name'],
      logo: json['logo'],
      address: json['address'],
      location: json['location'],
      // menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "delivery_id": delId,
        "kitchenid": kitchenId,
        "address_id": addId,
        "quantity": quantity,
        "price": price,
        "total_discount": totalDiscount,
        "delivery_charge": delCharge,
        "total_price": totPrice,
        "status": status,
        "datetime": dateTime,
        "payment_type": payType,
        "kitchen_name": kitchenName,
        "logo": logo,
        "address": address,
        "location": location,
        // "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

Future<ResForManageOrder> getManageOderData(String userId) async {
  print("User Id: $userId");
  var link = Uri.parse("https://wifyfood.com/api/users/manage_order/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForManageOrder.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<Order>> getManageOrderListData(String userId) async {
  print("User Id: $userId");
  List<Order> orders;
  var link = Uri.parse("https://wifyfood.com/api/users/manage_order/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["order"] as List;
    //print("Rest: $rest");
    orders = rest.map<Order>((json) => Order.fromJson(json)).toList();
    //print('List Size: ${orders.length}');

    return orders;
  } else {
    print('Exit');
    return null;
  }
}
