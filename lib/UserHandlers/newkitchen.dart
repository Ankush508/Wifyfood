import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForNewKitchenList> newKitchenListFromJson(String list) =>
    List<ResForNewKitchenList>.from(
      json.decode(list).map(
            (x) => ResForNewKitchenList.fromJson(x),
          ),
    );
String newKitchenListToJson(List<ResForNewKitchenList> list) => json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForNewKitchenList {
  int status;
  String response;
  List<KitchenList> kitchenList;

  ResForNewKitchenList({
    this.status,
    this.response,
    this.kitchenList,
  });

  factory ResForNewKitchenList.fromJson(Map<String, dynamic> json) {
    return ResForNewKitchenList(
      status: json['status'],
      response: json['response'],
      kitchenList: List<KitchenList>.from(
          json["kitchendetail"].map((x) => KitchenList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "kitchendetail": List<dynamic>.from(kitchenList.map((x) => x.toJson())),
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
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
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
        "bannerImage": bannerImage,
        "onlineoffline": onOff,
        "rating": rating,
        "favorite_kitchen": "null",
      };
}

Future<ResForNewKitchenList> getNewKitchenList(String cityId) async {
  print("City Id: $cityId");
  var link = Uri.parse("https://wifyfood.com/api/users/new_kitchen/$cityId");
  http.Response res = await http.get(
    link,
  );
  // print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForNewKitchenList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<KitchenList>> getNewKitchenListData(String cityId) async {
  print("City Id: $cityId");
  List<KitchenList> newKitchenList;
  var link = Uri.parse("https://wifyfood.com/api/users/new_kitchen/$cityId");
  http.Response res = await http.get(
    link,
  );
  // print('New Kitchen Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      var body = jsonDecode(res.body);
      var rest = body["kitchendetail"] as List;
      // print("Rest: $rest");
      newKitchenList =
          rest.map<KitchenList>((json) => KitchenList.fromJson(json)).toList();
      // print('List Size: ${newKitchenList.length}');

      return newKitchenList;
    } catch (e) {
      return newKitchenList = [];
    }
  } else {
    print('Exit');
    return newKitchenList = [];
    // return null;
  }
}
