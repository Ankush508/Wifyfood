import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForMenuList> addressListFromJson(String list) =>
    List<ResForMenuList>.from(
      json.decode(list).map(
            (x) => ResForMenuList.fromJson(x),
          ),
    );
String addressListToJson(List<ResForMenuList> menuList) => json.encode(
      List<dynamic>.from(
        menuList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForMenuList {
  int status;
  List<MenuList> menuList;

  ResForMenuList({
    this.status,
    this.menuList,
  });

  factory ResForMenuList.fromJson(Map<String, dynamic> json) {
    return ResForMenuList(
      status: json['status'],
      menuList: List<MenuList>.from(
          json["menulist"].map((x) => MenuList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "menulist": List<dynamic>.from(menuList.map((x) => x.toJson())),
      };
}

class MenuList {
  String id;
  String dishName;
  String description;
  String kitchenId;
  String price;
  String maxQuantity;
  String photo;
  String video;
  String status;

  MenuList({
    this.id,
    this.dishName,
    this.description,
    this.kitchenId,
    this.price,
    this.maxQuantity,
    this.photo,
    this.video,
    this.status,
  });

  factory MenuList.fromJson(Map<String, dynamic> json) {
    return MenuList(
      id: json['id'],
      dishName: json['dishname'],
      description: json['description'],
      kitchenId: json['kitchenid'],
      price: json['full_price'],
      maxQuantity: json['maximum_quantity'],
      photo: json['photo'],
      video: json['video'],
      status: json['status'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishname": dishName,
        "description": description,
        "kitchenid": kitchenId,
        "price": price,
        "maximum_quantity": maxQuantity,
        "photo": photo,
        "video": video,
        "status": status,
      };
}

class SpecialMenuList {
  String id;
  String dishName;
  String description;
  String kitchenId;
  String price;
  String maxQuantity;
  String photo;
  String video;
  String status;

  SpecialMenuList({
    this.id,
    this.dishName,
    this.description,
    this.kitchenId,
    this.price,
    this.maxQuantity,
    this.photo,
    this.video,
    this.status,
  });

  factory SpecialMenuList.fromJson(Map<String, dynamic> json) {
    return SpecialMenuList(
      id: json['id'],
      dishName: json['dishname'],
      description: json['description'],
      kitchenId: json['kitchenid'],
      price: json['full_price'],
      maxQuantity: json['maximum_quantity'],
      photo: json['photo'],
      video: json['video'],
      status: json['status'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishname": dishName,
        "description": description,
        "kitchenid": kitchenId,
        "price": price,
        "maximum_quantity": maxQuantity,
        "photo": photo,
        "video": video,
        "status": status,
      };
}

Future<ResForMenuList> getMenuList(String kitchenId) async {
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menulist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForMenuList.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForMenuList();
    }
  } else {
    print('Exit');
    return null;
  }
}

Future<List<MenuList>> getMenuListData(String kitchenId) async {
  List<MenuList> menuList;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menulist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["menulist"] as List;
    //print("Rest: $rest");
    try {
      menuList = rest.map<MenuList>((json) => MenuList.fromJson(json)).toList();
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

Future<List<SpecialMenuList>> getSpecialMenuListData(String kitchenId) async {
  List<SpecialMenuList> specialMenuList;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menulist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["specialmenulist"] as List;
    //print("Rest: $rest");
    try {
      specialMenuList = rest
          .map<SpecialMenuList>((json) => SpecialMenuList.fromJson(json))
          .toList();
    } catch (e) {
      specialMenuList = [];
    }
    //print('List Size: ${menuList.length}');

    return specialMenuList;
  } else {
    print('Exit');
    return null;
  }
}
