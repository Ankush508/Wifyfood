import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForDashboardUserList> dashboardUserListFromJson(String list) =>
    List<ResForDashboardUserList>.from(
      json.decode(list).map(
            (x) => ResForDashboardUserList.fromJson(x),
          ),
    );
String dashboardUserListToJson(List<ResForDashboardUserList> topPickList) =>
    json.encode(
      List<dynamic>.from(
        topPickList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForDashboardUserList {
  int status;
  int totalCashbackEarned;
  List<TopPick> topPick;
  List<Promoted> promoted;
  List<Special> special;

  ResForDashboardUserList({
    this.status,
    this.totalCashbackEarned,
    this.topPick,
    this.promoted,
    this.special,
  });

  factory ResForDashboardUserList.fromJson(Map<String, dynamic> json) {
    return ResForDashboardUserList(
      status: json['status'],
      totalCashbackEarned: json['Totalcashbackearned'],
      topPick:
          List<TopPick>.from(json["Toppick"].map((x) => TopPick.fromJson(x))),
      promoted: List<Promoted>.from(
          json["promoted"].map((x) => Promoted.fromJson(x))),
      special: List<Special>.from(
          json["special_offer"].map((x) => Special.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Totalcashbackearned": totalCashbackEarned,
        "Toppick": List<dynamic>.from(topPick.map((x) => x.toJson())),
        "promoted": List<dynamic>.from(promoted.map((x) => x.toJson())),
        "special_offer": List<dynamic>.from(special.map((x) => x.toJson())),
      };
}

class TopPick {
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

  TopPick({
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
    this.rating,
    this.bannerImage,
    this.onOff,
    this.fav,
  });

  factory TopPick.fromJson(Map<String, dynamic> json) {
    return TopPick(
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
        "onlineoffline": onOff,
        "banner_image": bannerImage,
        "rating": rating,
        "favorite_kitchen": fav,
      };
}

class Promoted {
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

  Promoted({
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

  factory Promoted.fromJson(Map<String, dynamic> json) {
    return Promoted(
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
      rating: json['rating'],
      bannerImage: json['banner_image'],
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
        "onlineoffline": onOff,
        "banner_image": bannerImage,
        "rating": rating,
        "favorite_kitchen": fav,
      };
}

class Special {
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

  Special({
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

  factory Special.fromJson(Map<String, dynamic> json) {
    return Special(
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
        "onlineoffline": onOff,
        "banner_image": bannerImage,
        "rating": rating,
        "favorite_kitchen": fav,
      };
}

Future<ResForDashboardUserList> getDashboardUserList(
    String userId, String lat, String long) async {
  var link = Uri.parse("https://wifyfood.com/api/users/dashboard/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForDashboardUserList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<TopPick>> getTopPickData(String userId) async {
  print("User Id Top Pick: $userId");
  // print("City Id: $cityId");
  List<TopPick> topPickList;
  var link = Uri.parse("https://wifyfood.com/api/users/dashboard/$userId");
  http.Response res = await http.get(
    link,
  );
  // print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      var body = jsonDecode(res.body);
      var rest = body["Toppick"] as List;
      //print("Rest: $rest");
      topPickList =
          rest.map<TopPick>((json) => TopPick.fromJson(json)).toList();
      //print('List Size: ${topPickList.length}');

      return topPickList;
    } catch (e) {
      return topPickList = [];
    }
  } else {
    print('Exit TopPick');
    return null; //topPickList = [];
  }
}

Future<List<Promoted>> getPromotedKitchenData(String userId) async {
  List<Promoted> promotedkitchenList;
  var link = Uri.parse("https://wifyfood.com/api/users/dashboard/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      var body = jsonDecode(res.body);
      var rest = body["promoted"] as List;
      //print("Rest: $rest");
      promotedkitchenList =
          rest.map<Promoted>((json) => Promoted.fromJson(json)).toList();
      //print('List Size: ${promotedkitchenList.length}');

      return promotedkitchenList;
    } catch (e) {
      return promotedkitchenList = [];
    }
  } else {
    print('Exit Promoted');
    return null; //promotedkitchenList = [];
  }
}

Future<List<Special>> getSpecialOfferData(String userId) async {
  List<Special> specialOfferList;
  var link = Uri.parse("https://wifyfood.com/api/users/dashboard/$userId");
  http.Response res = await http.get(
    link,
  );
  // print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      var body = jsonDecode(res.body);
      var rest = body["special_offer"] as List;
      //print("Rest: $rest");
      specialOfferList =
          rest.map<Special>((json) => Special.fromJson(json)).toList();
      //print('List Size: ${specialOfferList.length}');

      return specialOfferList;
    } catch (e) {
      return specialOfferList = [];
    }
  } else {
    print('Exit Special Offer');
    return null; //specialOfferList = [];
  }
}
