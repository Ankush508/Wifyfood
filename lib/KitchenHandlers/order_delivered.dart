import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForOrderDelivered> orderDeliveredListFromJson(String list) =>
    List<ResForOrderDelivered>.from(
      json.decode(list).map(
            (x) => ResForOrderDelivered.fromJson(x),
          ),
    );
String orderDeliveredListToJson(List<ResForOrderDelivered> list) => json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForOrderDelivered {
  int status;
  List<OrderDelivered> todayOrders;

  ResForOrderDelivered({
    this.status,
    this.todayOrders,
  });

  factory ResForOrderDelivered.fromJson(Map<String, dynamic> json) {
    return ResForOrderDelivered(
      status: json['status'],
      // totalCashbackEarned: json['Totalcashbackearned'],
      todayOrders: List<OrderDelivered>.from(
          json["today_Orders"].map((x) => OrderDelivered.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        // "Totalcashbackearned": totalCashbackEarned,
        "today_Orders": List<dynamic>.from(todayOrders.map((x) => x.toJson())),
      };
}

class OrderDelivered {
  String fullName;
  String lastName;
  String mobile;
  String orderQuantity;
  String totalPrice;
  String orderStatus;
  String orderId;
  List<Menu> menu;

  OrderDelivered({
    this.orderId,
    this.fullName,
    this.lastName,
    this.mobile,
    this.orderQuantity,
    this.totalPrice,
    this.orderStatus,
    this.menu,
  });

  factory OrderDelivered.fromJson(Map<String, dynamic> json) {
    return OrderDelivered(
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

Future<ResForOrderDelivered> getOrderDeliveredData(String userId) async {
  var link =
      Uri.parse("https://wifyfood.com/api/kitchen/order_delivered/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForOrderDelivered.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForOrderDelivered();
    }
  } else {
    print('Exit');
    return null;
  }
}

Future<List<OrderDelivered>> getOrderDeliveredListData(String userId) async {
  List<OrderDelivered> orderDeliveredList;
  var link =
      Uri.parse("https://wifyfood.com/api/kitchen/order_delivered/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["orderdelivered"] as List;
    //print("Rest: $rest");
    try {
      orderDeliveredList = rest
          .map<OrderDelivered>((json) => OrderDelivered.fromJson(json))
          .toList();
    } catch (e) {
      orderDeliveredList = [];
    }
    //print('List Size: ${orderDeliveredList.length}');

    return orderDeliveredList;
  } else {
    print('Exit');
    return null;
  }
}
