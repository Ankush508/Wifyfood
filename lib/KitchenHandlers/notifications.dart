import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForNotificationList> notListFromJson(String list) =>
    List<ResForNotificationList>.from(
      json.decode(list).map(
            (x) => ResForNotificationList.fromJson(x),
          ),
    );
String notListToJson(List<ResForNotificationList> menuList) => json.encode(
      List<dynamic>.from(
        menuList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForNotificationList {
  int status;
  String response;
  List<Data> notList;

  ResForNotificationList({
    this.status,
    this.response,
    this.notList,
  });

  factory ResForNotificationList.fromJson(Map<String, dynamic> json) {
    return ResForNotificationList(
      status: json['status'],
      response: json['response'],
      notList: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "data": List<dynamic>.from(notList.map((x) => x.toJson())),
      };
}

class Data {
  String message;
  String dateTime;
  String description;

  Data({
    this.message,
    this.dateTime,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json['message'],
      dateTime: json['date_time'],
      description: json['discription'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "date_time": dateTime,
        "discription": description,
      };
}

Future<ResForNotificationList> getNotificationList(String kitchenId) async {
  print("Kitchen Id: $kitchenId");
  var link = Uri.parse(
      "https://wifyfood.com/api/kitchen/kitchen_notification/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForNotificationList.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForNotificationList();
    }
  } else {
    print('Exit');
    return null;
  }
}

Future<List<Data>> getNotificationListData(String kitchenId) async {
  print("Kitchen Id: $kitchenId");
  List<Data> menuList;
  var link = Uri.parse(
      "https://wifyfood.com/api/kitchen/kitchen_notification/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["notification"] as List;
    //print("Rest: $rest");
    try {
      menuList = rest.map<Data>((json) => Data.fromJson(json)).toList();
    } catch (e) {
      menuList = [];
    }
    //print('List Size: ${menuList.length}');
    return menuList;
  } else {
    print('Exit');
    return null;
  }
}
