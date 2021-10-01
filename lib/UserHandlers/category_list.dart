import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForCategoryList> menuListFromJson(String list) =>
    List<ResForCategoryList>.from(
      json.decode(list).map(
            (x) => ResForCategoryList.fromJson(x),
          ),
    );
String menuListToJson(List<ResForCategoryList> categoryList) => json.encode(
      List<dynamic>.from(
        categoryList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForCategoryList {
  int status;
  List<CategoryList> categoryList;

  ResForCategoryList({
    this.status,
    this.categoryList,
  });

  factory ResForCategoryList.fromJson(Map<String, dynamic> json) {
    return ResForCategoryList(
      status: json['status'],
      categoryList: List<CategoryList>.from(
          json["categorylist"].map((x) => CategoryList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "categorylist": List<dynamic>.from(categoryList.map((x) => x.toJson())),
      };
}

class CategoryList {
  String id;
  String name;
  String count;

  CategoryList({
    this.id,
    this.name,
    this.count,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
      id: json['id'],
      name: json['name'],
      count: json['count'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
      };
}

Future<ResForCategoryList> getCategoryList(String kitchenId) async {
  var link =
      Uri.parse("https://wifyfood.com/api/users/categorylist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForCategoryList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<CategoryList>> getCategoryListData(String kitchenId) async {
  List<CategoryList> categoryList;
  var link =
      Uri.parse("https://wifyfood.com/api/users/categorylist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["categorylist"] as List;
    //print("Rest: $rest");
    categoryList =
        rest.map<CategoryList>((json) => CategoryList.fromJson(json)).toList();
    //print('List Size: ${categoryList.length}');
    return categoryList;
  } else {
    print('Exit');
    return null;
  }
}
