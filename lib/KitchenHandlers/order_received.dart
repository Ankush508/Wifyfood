import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForOrderReceived> orderReceivedListFromJson(String list) =>
    List<ResForOrderReceived>.from(
      json.decode(list).map(
            (x) => ResForOrderReceived.fromJson(x),
          ),
    );
String orderReceivedListToJson(List<ResForOrderReceived> list) => json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForOrderReceived {
  int status;
  List<OrderReceived> todayOrders;

  ResForOrderReceived({
    this.status,
    this.todayOrders,
  });

  factory ResForOrderReceived.fromJson(Map<String, dynamic> json) {
    return ResForOrderReceived(
      status: json['status'],
      // totalCashbackEarned: json['Totalcashbackearned'],
      todayOrders: List<OrderReceived>.from(
          json["orderreceived"].map((x) => OrderReceived.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        // "Totalcashbackearned": totalCashbackEarned,
        "orderreceived": List<dynamic>.from(todayOrders.map((x) => x.toJson())),
      };
}

class OrderReceived {
  String fullName;
  String lastName;
  String mobile;
  String orderQuantity;
  String totalPrice;
  String orderStatus;
  String orderId;
  List<Menu> menu;

  OrderReceived({
    this.orderId,
    this.fullName,
    this.lastName,
    this.mobile,
    this.orderQuantity,
    this.totalPrice,
    this.orderStatus,
    this.menu,
  });

  factory OrderReceived.fromJson(Map<String, dynamic> json) {
    return OrderReceived(
      orderId: json['order_id'],
      fullName: json['f_name'],
      lastName: json['l_name'],
      mobile: json['mobile'],
      orderQuantity: json['orderquantity'],
      totalPrice: json['ordertotal_price'],
      orderStatus: json['orderstatus'],
      menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "f_name": fullName,
        "l_name": lastName,
        "mobile": mobile,
        "orderquantity": orderQuantity,
        "ordertotal_price": totalPrice,
        "orderstatus": orderStatus,
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class Menu {
  String id;
  String dishName;
  String des;
  String kitchenId;
  String foodType;
  String category;
  String userId;
  String price;
  String orderId;
  String itemId;
  String quantity;
  String discount;
  String delCharges;
  String status;

  Menu({
    this.dishName,
    this.foodType,
    this.id,
    this.userId,
    this.kitchenId,
    this.orderId,
    this.itemId,
    this.quantity,
    this.price,
    this.discount,
    this.delCharges,
    this.status,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      dishName: json['dishname'],
      foodType: json['food_type'],
      id: json['id'],
      userId: json['user_id'],
      kitchenId: json['kitchen_id'],
      orderId: json['order_id'],
      itemId: json['item_id'],
      quantity: json['itemquantitys'],
      price: json['price'],
      discount: json['discount'],
      delCharges: json['delivery_charges'],
      status: json['status'],
      // menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "dishname": dishName,
        "food_type": foodType,
        "id": id,
        "user_id": userId,
        "kitchen_id": kitchenId,
        "order_id": orderId,
        "item_id": itemId,
        "itemquantitys": quantity,
        "price": price,
        "discount": discount,
        "delivery_charges": delCharges,
        "status": status,
        // "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

Future<ResForOrderReceived> getOrderReceivedData(String userId) async {
  var link =
      Uri.parse("https://wifyfood.com/api/kitchen/order_received/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForOrderReceived.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForOrderReceived();
    }
  } else {
    print('Exit');
    return null;
  }
}

Future<List<OrderReceived>> getOrderReceivedListData(String userId) async {
  List<OrderReceived> orderReceivedList;
  var link =
      Uri.parse("https://wifyfood.com/api/kitchen/order_received/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["orderreceived"] as List;
    //print("Rest: $rest");
    try {
      orderReceivedList = rest
          .map<OrderReceived>((json) => OrderReceived.fromJson(json))
          .toList();
    } catch (e) {
      orderReceivedList = [];
    }
    //print('List Size: ${orderReceivedList.length}');

    return orderReceivedList;
  } else {
    print('Exit');
    return null;
  }
}
