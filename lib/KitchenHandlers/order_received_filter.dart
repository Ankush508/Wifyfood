import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForOrderReceivedFilter> orderReceivedListFromJson(String list) =>
    List<ResForOrderReceivedFilter>.from(
      json.decode(list).map(
            (x) => ResForOrderReceivedFilter.fromJson(x),
          ),
    );
String orderReceivedListToJson(List<ResForOrderReceivedFilter> list) =>
    json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForOrderReceivedFilter {
  int status;
  List<OrderReceivedFilter> todayOrders;

  ResForOrderReceivedFilter({
    this.status,
    this.todayOrders,
  });

  factory ResForOrderReceivedFilter.fromJson(Map<String, dynamic> json) {
    return ResForOrderReceivedFilter(
      status: json['status'],
      // totalCashbackEarned: json['Totalcashbackearned'],
      todayOrders: List<OrderReceivedFilter>.from(json["orderreceivedfilter"]
          .map((x) => OrderReceivedFilter.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        // "Totalcashbackearned": totalCashbackEarned,
        "orderreceivedfilter":
            List<dynamic>.from(todayOrders.map((x) => x.toJson())),
      };
}

class OrderReceivedFilter {
  String fullName;
  String lastName;
  String mobile;
  String orderQuantity;
  String totalPrice;
  String orderStatus;
  String orderId;
  List<Menu> menu;

  OrderReceivedFilter({
    this.orderId,
    this.fullName,
    this.lastName,
    this.mobile,
    this.orderQuantity,
    this.totalPrice,
    this.orderStatus,
    this.menu,
  });

  factory OrderReceivedFilter.fromJson(Map<String, dynamic> json) {
    return OrderReceivedFilter(
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

Future<ResForOrderReceivedFilter> getOrderReceivedFilterData(
    String kId, String date) async {
  print("Kitchen Id: $kId");
  print("Date: $date");
  var link =
      Uri.parse("https://wifyfood.com/api/kitchen/order_received_filter");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "kitchen_id": kId,
          "datetime": date,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForOrderReceivedFilter.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForOrderReceivedFilter();
    }
  } else {
    print('Exit');
    return null;
  }
}

Future<List<OrderReceivedFilter>> getOrderReceivedFilterListData(
    String kId, String date) async {
  print("Kitchen Id: $kId");
  print("Date: $date");
  List<OrderReceivedFilter> orderReceivedList;
  var link =
      Uri.parse("https://wifyfood.com/api/kitchen/order_received_filter");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "kitchen_id": kId,
          "datetime": date,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["orderreceivedfilter"] as List;
    //print("Rest: $rest");
    try {
      orderReceivedList = rest
          .map<OrderReceivedFilter>(
              (json) => OrderReceivedFilter.fromJson(json))
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
