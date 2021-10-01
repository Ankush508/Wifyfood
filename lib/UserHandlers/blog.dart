import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForBlog> blogListFromJson(String list) => List<ResForBlog>.from(
      json.decode(list).map(
            (x) => ResForBlog.fromJson(x),
          ),
    );
String blogListToJson(List<ResForBlog> menuList) => json.encode(
      List<dynamic>.from(
        menuList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForBlog {
  int status;
  String response;
  List<UserBlog> userBlog;

  ResForBlog({
    this.status,
    this.response,
    this.userBlog,
  });

  factory ResForBlog.fromJson(Map<String, dynamic> json) {
    return ResForBlog(
      status: json['status'],
      response: json['response'],
      userBlog: List<UserBlog>.from(
          json["userblog"].map((x) => UserBlog.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "userblog": List<dynamic>.from(userBlog.map((x) => x.toJson())),
      };
}

class UserBlog {
  String rate;
  String kitchenId;
  String location;
  String cuisine;
  String message;
  String kitchenName;
  String distance;
  String logo;
  String bannerImage;

  UserBlog({
    this.rate,
    this.kitchenId,
    this.location,
    this.cuisine,
    this.message,
    this.kitchenName,
    this.distance,
    this.logo,
    this.bannerImage,
  });

  factory UserBlog.fromJson(Map<String, dynamic> json) {
    return UserBlog(
      rate: json['totalrating'],
      kitchenId: json['id'],
      location: json['location'],
      cuisine: json['cuisine'],
      message: json['message'],
      kitchenName: json['kitchen_name'],
      distance: json['distance'],
      logo: json['photo'],
      bannerImage: json['banner_image'],

      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalrating": rate,
        "id": kitchenId,
        "location": location,
        "cuisine": cuisine,
        "message": message,
        "kitchen_name": kitchenName,
        "distance": distance,
        "photo": logo,
        "banner_image": bannerImage,
      };
}

Future<ResForBlog> getUserBlogData(String userId) async {
  var link =
      Uri.parse("https://wifyfood.com/api/users/users_blog_list/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForBlog.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<UserBlog>> getUserBlogListData(String userId) async {
  print("Blog User Id: $userId");
  List<UserBlog> menuList;
  var link =
      Uri.parse("https://wifyfood.com/api/users/users_blog_list/$userId");
  http.Response res = await http.get(
    link,
  );
  // print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["userblog"] as List;
    //print("Rest: $rest");
    menuList = rest.map<UserBlog>((json) => UserBlog.fromJson(json)).toList();
    //print('List Size: ${menuList.length}');
    return menuList;
  } else {
    print('Exit');
    return null;
  }
}
