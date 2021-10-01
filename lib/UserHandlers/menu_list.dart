import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForMenuList> menuListFromJson(String list) => List<ResForMenuList>.from(
      json.decode(list).map(
            (x) => ResForMenuList.fromJson(x),
          ),
    );
String menuListToJson(List<ResForMenuList> menuList) => json.encode(
      List<dynamic>.from(
        menuList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForMenuList {
  int status;
  String data;
  List<MenuList> menuList;

  ResForMenuList({
    this.status,
    this.data,
    this.menuList,
  });

  factory ResForMenuList.fromJson(Map<String, dynamic> json) {
    return ResForMenuList(
      status: json['status'],
      data: json['response'],
      menuList: List<MenuList>.from(
          json["menulist"].map((x) => MenuList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": data,
        "menulist": List<dynamic>.from(menuList.map((x) => x.toJson())),
      };
}

class MenuList {
  String id;
  String dishName;
  String description;
  String kitchenId;
  String foodType;
  String category;
  String halfPrice;
  String fullPrice;
  String maxQuantity;
  String photo;
  String video;
  String status;
  String priceType;

  MenuList({
    this.id,
    this.dishName,
    this.description,
    this.kitchenId,
    this.foodType,
    this.category,
    this.halfPrice,
    this.fullPrice,
    this.maxQuantity,
    this.photo,
    this.video,
    this.status,
    this.priceType,
  });

  factory MenuList.fromJson(Map<String, dynamic> json) {
    return MenuList(
      id: json['id'],
      dishName: json['dishname'],
      description: json['description'],
      kitchenId: json['kitchenid'],
      foodType: json['food_type'],
      category: json['category'],
      halfPrice: json['half_price'],
      fullPrice: json['full_price'],
      maxQuantity: json['maximum_quantity'],
      photo: json['photo'],
      video: json['video'],
      status: json['status'],
      priceType: json['price_type'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishname": dishName,
        "description": description,
        "kitchenid": kitchenId,
        "food_type": foodType,
        "category": category,
        "full_price": fullPrice,
        "half_price": halfPrice,
        "maximum_quantity": maxQuantity,
        "photo": photo,
        "video": video,
        "status": status,
        "price_type": priceType,
      };
}

class SpecialMenuList {
  String id;
  String dishName;
  String description;
  String kitchenId;
  String foodType;
  String category;
  String halfPrice;
  String fullPrice;
  String maxQuantity;
  String photo;
  String video;
  String status;
  String priceType;

  SpecialMenuList({
    this.id,
    this.dishName,
    this.description,
    this.kitchenId,
    this.foodType,
    this.category,
    this.halfPrice,
    this.fullPrice,
    this.maxQuantity,
    this.photo,
    this.video,
    this.status,
    this.priceType,
  });

  factory SpecialMenuList.fromJson(Map<String, dynamic> json) {
    return SpecialMenuList(
      id: json['id'],
      dishName: json['dishname'],
      description: json['description'],
      kitchenId: json['kitchenid'],
      foodType: json['food_type'],
      category: json['category'],
      halfPrice: json['half_price'],
      fullPrice: json['full_price'],
      maxQuantity: json['maximum_quantity'],
      photo: json['photo'],
      video: json['video'],
      status: json['status'],
      priceType: json['price_type'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishname": dishName,
        "description": description,
        "kitchenid": kitchenId,
        "food_type": foodType,
        "category": category,
        "full_price": fullPrice,
        "half_price": halfPrice,
        "maximum_quantity": maxQuantity,
        "photo": photo,
        "video": video,
        "status": status,
        "price_type": priceType,
      };
}

Future<ResForMenuList> getMenuList(String kitchenId) async {
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menu_list/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForMenuList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<MenuList>> getMenuListData(String kitchenId) async {
  print("Kitchen Id: $kitchenId");
  List<MenuList> menuList;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menu_list/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["menulist"] as List;
    //print("Rest: $rest");
    menuList = rest.map<MenuList>((json) => MenuList.fromJson(json)).toList();
    //print('List Size: ${menuList.length}');
    return menuList;
  } else {
    print('Exit');
    return null;
  }
}

Future<List<SpecialMenuList>> getSpecialMenuListData(String kitchenId) async {
  print("Kitchen Id: $kitchenId");
  List<SpecialMenuList> specialMenuList;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menu_list/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["specialmenulist"] as List;
    //print("Rest: $rest");
    specialMenuList = rest
        .map<SpecialMenuList>((json) => SpecialMenuList.fromJson(json))
        .toList();
    //print('List Size: ${menuList.length}');
    return specialMenuList;
  } else {
    print('Exit');
    return null;
  }
}
