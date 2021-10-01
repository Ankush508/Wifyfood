import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForSearchKitchenList> searchKitchenListFromJson(String list) =>
    List<ResForSearchKitchenList>.from(
      json.decode(list).map(
            (x) => ResForSearchKitchenList.fromJson(x),
          ),
    );
String searchKitchenListToJson(List<ResForSearchKitchenList> list) =>
    json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForSearchKitchenList {
  int status;
  int totalCashbackEarned;
  List<KitchenList> kitchenList;

  ResForSearchKitchenList({
    this.status,
    this.totalCashbackEarned,
    this.kitchenList,
  });

  factory ResForSearchKitchenList.fromJson(Map<String, dynamic> json) {
    return ResForSearchKitchenList(
      status: json['status'],
      totalCashbackEarned: json['Totalcashbackearned'],
      kitchenList: List<KitchenList>.from(
          json["kitchenlist"].map((x) => KitchenList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Totalcashbackearned": totalCashbackEarned,
        "kitchenlist": List<dynamic>.from(kitchenList.map((x) => x.toJson())),
      };
}

class KitchenList {
  String id;
  String ownerName;
  String ownerDob;
  String kitchenName;
  String cuisine;
  String email;
  String location;
  String latitude;
  String longitude;
  String pincode;
  String mobile;
  String logo;
  String otp;
  String password;
  String deviceId;
  String status;
  String type;
  String bannerImage;
  String rating;
  String onOff;
  String fav;
  List<MenuNameList> menuNameList;

  KitchenList({
    this.id,
    this.ownerName,
    this.ownerDob,
    this.kitchenName,
    this.cuisine,
    this.email,
    this.location,
    this.latitude,
    this.longitude,
    this.pincode,
    this.mobile,
    this.logo,
    this.otp,
    this.password,
    this.deviceId,
    this.status,
    this.type,
    this.bannerImage,
    this.rating,
    this.onOff,
    this.fav,
    this.menuNameList,
  });

  factory KitchenList.fromJson(Map<String, dynamic> json) {
    return KitchenList(
      id: json['id'],
      ownerName: json['owner_name'],
      ownerDob: json['owner_dob'],
      kitchenName: json['kitchen_name'],
      cuisine: json['cuisine'],
      email: json['email'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      pincode: json['pincode'],
      mobile: json['mobile'],
      logo: json['logo'],
      otp: json['otp'],
      password: json['password'],
      deviceId: json['device_id'],
      status: json['status'],
      type: json['type'],
      bannerImage: json['banner_image'],
      rating: json['rating'],
      onOff: json['onlineoffline'],
      fav: json['favorite_kitchen'],
      menuNameList: List<MenuNameList>.from(
          json["menu_name"].map((x) => MenuNameList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_name": ownerName,
        "owner_dob": ownerDob,
        "kitchen_name": kitchenName,
        "cuisine": cuisine,
        "email": email,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "pincode": pincode,
        "mobile": mobile,
        "logo": logo,
        "otp": otp,
        "password": password,
        "device_id": deviceId,
        "status": status,
        "type": type,
        "banner_image": bannerImage,
        "onlineoffline": onOff,
        "rating": rating,
        "favorite_kitchen": "null",
        "menu_name": List<dynamic>.from(menuNameList.map((x) => x.toJson())),
      };
}

class MenuNameList {
  String dishname;

  MenuNameList({
    this.dishname,
  });

  factory MenuNameList.fromJson(Map<String, dynamic> json) {
    return MenuNameList(
      dishname: json['dishname'],

      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "dishname": dishname,
      };
}

Future<ResForSearchKitchenList> getSearchKitchenList(String userId) async {
  var link = Uri.parse("https://wifyfood.com/api/users/search_kitchen/$userId");
  http.Response res = await http.get(
    link,
  );
  // print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForSearchKitchenList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<KitchenList>> getSearchKitchenData(String userId) async {
  List<KitchenList> searchKitchenList;
  var link = Uri.parse("https://wifyfood.com/api/users/search_kitchen/$userId");
  http.Response res = await http.get(
    link,
  );
  // print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["kitchenlist"] as List;
    // print("Rest: $rest");
    searchKitchenList =
        rest.map<KitchenList>((json) => KitchenList.fromJson(json)).toList();
    print('List Size: ${searchKitchenList.length}');

    return searchKitchenList;
  } else {
    print('Exit');
    return null;
  }
}
