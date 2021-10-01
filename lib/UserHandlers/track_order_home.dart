import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForTrackOrder> menuListFromJson(String list) =>
    List<ResForTrackOrder>.from(
      json.decode(list).map(
            (x) => ResForTrackOrder.fromJson(x),
          ),
    );
String menuListToJson(List<ResForTrackOrder> menuList) => json.encode(
      List<dynamic>.from(
        menuList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForTrackOrder {
  int status;
  List<KitchenDetail> kitchenDetail;
  List<MenuDetail> menuDetailList;
  List<DeliveryDetail> deliveryDetail;

  ResForTrackOrder({
    this.status,
    this.kitchenDetail,
    this.menuDetailList,
    this.deliveryDetail,
  });

  factory ResForTrackOrder.fromJson(Map<String, dynamic> json) {
    return ResForTrackOrder(
      status: json['status'],
      kitchenDetail: List<KitchenDetail>.from(
          json["kitchendetail"].map((x) => KitchenDetail.fromJson(x))),
      menuDetailList: List<MenuDetail>.from(
          json["menudetail"].map((x) => MenuDetail.fromJson(x))),
      deliveryDetail: List<DeliveryDetail>.from(
          json["deliverydetail"].map((x) => DeliveryDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "kitchendetail":
            List<dynamic>.from(kitchenDetail.map((x) => x.toJson())),
        "menudetail": List<dynamic>.from(menuDetailList.map((x) => x.toJson())),
        "deliverydetail":
            List<dynamic>.from(deliveryDetail.map((x) => x.toJson())),
      };
}

class KitchenDetail {
  String lat;
  String long;

  KitchenDetail({
    this.lat,
    this.long,
  });

  factory KitchenDetail.fromJson(Map<String, dynamic> json) {
    return KitchenDetail(
      lat: json['latitude'],
      long: json['longitude'],

      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": lat,
        "longitude": long,
      };
}

class MenuDetail {
  String id;
  String orderId;
  String userId;
  String status;
  String dateTime;

  MenuDetail({
    this.id,
    this.orderId,
    this.userId,
    this.status,
    this.dateTime,
  });

  factory MenuDetail.fromJson(Map<String, dynamic> json) {
    return MenuDetail(
      id: json['id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      status: json['status'],
      dateTime: json['date_time'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "status": status,
        "date_time": dateTime,
      };
}

class DeliveryDetail {
  String lat;
  String long;

  DeliveryDetail({
    this.lat,
    this.long,
  });

  factory DeliveryDetail.fromJson(Map<String, dynamic> json) {
    return DeliveryDetail(
      lat: json['latitude'],
      long: json['longitude'],

      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": lat,
        "longitude": long,
      };
}

Future<ResForTrackOrder> getTrackOrderHomeData(String userId) async {
  var link =
      Uri.parse("https://wifyfood.com/api/users/dashboard_trackorder/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForTrackOrder.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<MenuDetail>> getTrackOrderHomeMenuListData(String userId) async {
  List<MenuDetail> menuList;
  var link =
      Uri.parse("https://wifyfood.com/api/users/dashboard_trackorder/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["menudetail"] as List;
    //print("Rest: $rest");
    menuList =
        rest.map<MenuDetail>((json) => MenuDetail.fromJson(json)).toList();
    //print('List Size: ${menuList.length}');
    return menuList;
  } else {
    print('Exit');
    return null;
  }
}

Future<List<DeliveryDetail>> getTrackOrderHomeDelListData(String userId) async {
  List<DeliveryDetail> menuList;
  var link =
      Uri.parse("https://wifyfood.com/api/users/dashboard_trackorder/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      var body = jsonDecode(res.body);
      var rest = body["deliverydetail"] as List;
      //print("Rest: $rest");
      menuList = rest
          .map<DeliveryDetail>((json) => DeliveryDetail.fromJson(json))
          .toList();
      //print('List Size: ${menuList.length}');
      return menuList;
    } catch (e) {
      return menuList = [];
    }
  } else {
    print('Exit');
    return null;
  }
}

Future<List<KitchenDetail>> getTrackOrderHomeKitListData(String userId) async {
  print("Use Id : $userId");
  List<KitchenDetail> menuList;
  var link =
      Uri.parse("https://wifyfood.com/api/users/dashboard_trackorder/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["kitchendetail"] as List;
    //print("Rest: $rest");
    menuList = rest
        .map<KitchenDetail>((json) => KitchenDetail.fromJson(json))
        .toList();
    //print('List Size: ${menuList.length}');
    return menuList;
  } else {
    print('Exit');
    return null;
  }
}
