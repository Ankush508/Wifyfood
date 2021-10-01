import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wifyfood/Helper/CommonFunctions.dart';

List<ResForKitchenDashboard> kitchenDashboardListFromJson(String list) =>
    List<ResForKitchenDashboard>.from(
      json.decode(list).map(
            (x) => ResForKitchenDashboard.fromJson(x),
          ),
    );
String kitchenDashboardListToJson(List<ResForKitchenDashboard> list) =>
    json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForKitchenDashboard {
  int status;
  int todayOrder;
  int monthlyOrder;
  int todayEarn;
  int monthlyEarn;
  List<TodayOrders> todayOrders;
  List<PendingOrders> pendingOrders;

  ResForKitchenDashboard({
    this.status,
    this.todayOrder,
    this.monthlyOrder,
    this.todayEarn,
    this.monthlyEarn,
    this.todayOrders,
    this.pendingOrders,
  });

  factory ResForKitchenDashboard.fromJson(Map<String, dynamic> json) {
    return ResForKitchenDashboard(
      status: json['status'],
      todayOrder: json['Today_order'],
      monthlyOrder: json['mothly_order'],
      todayEarn: json['Today_earning'],
      monthlyEarn: json['mothly_earning'],
      // totalCashbackEarned: json['Totalcashbackearned'],
      todayOrders: List<TodayOrders>.from(
          json["today_Orders"].map((x) => TodayOrders.fromJson(x))),
      pendingOrders: List<PendingOrders>.from(
          json["Pending_Orders"].map((x) => PendingOrders.fromJson(x))),
    );
  }

  ResForKitchenDashboard1(Map<String, dynamic> json) {
    return ResForKitchenDashboard(
      status: json['status'],
      todayOrder: json['Today_order'],
      monthlyOrder: json['mothly_order'],
      todayEarn: json['Today_earning'],
      monthlyEarn: json['mothly_earning'],
      // totalCashbackEarned: json['Totalcashbackearned'],
      todayOrders: List<TodayOrders>.from(
          json["today_Orders"].map((x) => TodayOrders.fromJson(x))),
      pendingOrders: List<PendingOrders>.from(
          json["Pending_Orders"].map((x) => PendingOrders.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": "0",
        "Today_order": "0",
        "mothly_order": "0",
        "Today_earning": "0",
        "mothly_earning": "0",

        // "Totalcashbackearned": totalCashbackEarned,
        "today_Orders": List<dynamic>.from(todayOrders.map((x) => x.toJson())),
        "Pending_Orders":
            List<dynamic>.from(pendingOrders.map((x) => x.toJson())),
      };
}

class TodayOrders {
  String orderId;
  String fullName;
  String lastName;
  String mobile;
  String orderQuntity;
  String totalPrice;
  String orderStatus;
  List<Menu> menu;

  TodayOrders({
    this.orderId,
    this.fullName,
    this.lastName,
    this.mobile,
    this.orderQuntity,
    this.totalPrice,
    this.orderStatus,
    this.menu,
  });

  factory TodayOrders.fromJson(Map<String, dynamic> json) {
    return TodayOrders(
      orderId: json['order_id'],
      fullName: json['f_name'],
      lastName: json['l_name'],
      mobile: json['mobile'],
      orderQuntity: json['orderquantity'],
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
        "orderquantity": orderQuntity,
        "ordertotal_price": totalPrice,
        "orderstatus": orderStatus,
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class Menu {
  String dishName;
  String priceType;
  String id;
  String userId;
  String kitchenId;
  String orderId;
  String itemId;
  String quantity;
  String price;
  String discount;
  String delCharges;
  String status;

  Menu({
    this.dishName,
    this.priceType,
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
      priceType: json['price_type'],
      id: json['id'],
      userId: json['user_id'],
      kitchenId: json['kitchen_id'],
      orderId: json['order_id'],
      itemId: json['itemId'],
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
        "price_type": priceType,
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

class PendingOrders {
  String orderId;
  String fullName;
  String lastName;
  String mobile;
  String dfname;
  String dlname;
  String dmob;
  String orderQuntity;
  String totalPrice;
  String orderStatus;
  List<Menu> menu;

  PendingOrders({
    this.orderId,
    this.fullName,
    this.lastName,
    this.mobile,
    this.dfname,
    this.dlname,
    this.dmob,
    this.orderQuntity,
    this.totalPrice,
    this.orderStatus,
    this.menu,
  });

  factory PendingOrders.fromJson(Map<String, dynamic> json) {
    return PendingOrders(
      orderId: json['order_id'],
      fullName: json['f_name'],
      lastName: json['l_name'],
      mobile: json['mobile'],
      dfname: json['df_name'],
      dlname: json['dl_name'],
      dmob: json['d_mobile'],
      orderQuntity: json['orderquantity'],
      totalPrice: json['ordertotal_price'],
      orderStatus: json['orderstatus'],
      menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "f_name": fullName,
        "l_name": lastName,
        "mobile": mobile,
        "orderquantity": orderQuntity,
        "ordertotal_price": totalPrice,
        "orderstatus": orderStatus,
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

Future<ResForKitchenDashboard> getKitchenDashboardData(String userId) async {
  print("kID: $userId");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/dashboard/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  CommonFunctions.console("kitchen dashboard:-----------------" + res.body);

  if (res.statusCode == 200) {
    return ResForKitchenDashboard.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<TodayOrders>> getTodayOrdersListData(String userId) async {
  List<TodayOrders> todayOrderList;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/dashboard/$userId");
  http.Response res = await http.get(
    link,
  );
  CommonFunctions.console("today order:-----------------" + res.body);

  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["today_Orders"] as List;
    //print("Rest: $rest");
    try {
      todayOrderList =
          rest.map<TodayOrders>((json) => TodayOrders.fromJson(json)).toList();
    } catch (e) {
      todayOrderList = [];
    }
    //print('List Size: ${todayOrderList.length}');

    return todayOrderList;
  } else {
    print('Exit');
    return null;
  }
}

Future<List<PendingOrders>> getPendingOrdersListData(String userId,
    [howMany = 5]) async {
  List<PendingOrders> pendingOrderList;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/dashboard/$userId");
  http.Response res = await http.get(
    link,
  );
  CommonFunctions.console("pending order:-----------------" + res.body);
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["Pending_Orders"] as List;
    //print("Rest: $rest");
    try {
      pendingOrderList = rest
          .map<PendingOrders>((json) => PendingOrders.fromJson(json))
          .toList();
    } catch (e) {
      pendingOrderList = [];
    }
    print('List Size: ${pendingOrderList.length}');

    return pendingOrderList;
  } else {
    print('Exit');
    return null;
  }
}
