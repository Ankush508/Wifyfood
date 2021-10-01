import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForMenuCategoryList> menuListFromJson(String list) =>
    List<ResForMenuCategoryList>.from(
      json.decode(list).map(
            (x) => ResForMenuCategoryList.fromJson(x),
          ),
    );
String menuListToJson(List<ResForMenuCategoryList> menuCategoryList) =>
    json.encode(
      List<dynamic>.from(
        menuCategoryList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForMenuCategoryList {
  int status;
  List<MenuCategoryList> menuCategoryList;

  ResForMenuCategoryList({
    this.status,
    this.menuCategoryList,
  });

  factory ResForMenuCategoryList.fromJson(Map<String, dynamic> json) {
    return ResForMenuCategoryList(
      status: json['status'],
      menuCategoryList: List<MenuCategoryList>.from(
          json["menucategorylist"].map((x) => MenuCategoryList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "menucategorylist":
            List<dynamic>.from(menuCategoryList.map((x) => x.toJson())),
      };
}

class MenuCategoryList {
  String id;
  String dishName;
  String description;
  String kitchenId;
  String foodType;
  String category;
  String fullprice;
  String halfprice;
  String maxQuantity;
  String photo;
  String video;
  String status;
  String priceType;

  MenuCategoryList({
    this.id,
    this.dishName,
    this.description,
    this.kitchenId,
    this.foodType,
    this.category,
    this.fullprice,
    this.halfprice,
    this.maxQuantity,
    this.photo,
    this.video,
    this.status,
    this.priceType,
  });

  factory MenuCategoryList.fromJson(Map<String, dynamic> json) {
    return MenuCategoryList(
        id: json['id'],
        dishName: json['dishname'],
        description: json['description'],
        kitchenId: json['kitchenid'],
        foodType: json['food_type'],
        category: json['category'],
        fullprice: json['full_price'],
        halfprice: json['half_price'],
        maxQuantity: json['maximum_quantity'],
        photo: json['photo'],
        video: json['video'],
        status: json['status'],
        priceType: json['price_type']
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
        "full_price": fullprice,
        "half_price": halfprice,
        "maximum_quantity": maxQuantity,
        "photo": photo,
        "video": video,
        "status": status,
        "price_type": priceType,
      };
}

Future<ResForMenuCategoryList> getMenuCategoryList(
    String kitchenId, String categoryId) async {
  print("KitchenId: $kitchenId");
  print("CategoryId: $categoryId");
  var link = Uri.parse(
      "https://wifyfood.com/api/users/menucategorylist/$kitchenId/$categoryId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForMenuCategoryList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<MenuCategoryList>> getMenuCategoryListData(
    String kitchenId, String categoryId) async {
  print("KitchenId: $kitchenId");
  print("Category Id: $categoryId");
  List<MenuCategoryList> menuCategoryList;
  var link = Uri.parse(
      "https://wifyfood.com/api/users/menucategorylist/$kitchenId/$categoryId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["menucategorylist"] as List;
    //print("Rest: $rest");
    menuCategoryList = rest
        .map<MenuCategoryList>((json) => MenuCategoryList.fromJson(json))
        .toList();
    //print('List Size: ${menuCategoryList.length}');
    return menuCategoryList;
  } else {
    print('Exit');
    return null;
  }
}
