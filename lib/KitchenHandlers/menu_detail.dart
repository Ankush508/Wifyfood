import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForMenuDetail {
  int status;
  MenuDetail menuDetail;

  ResForMenuDetail({
    this.status,
    this.menuDetail,
  });

  factory ResForMenuDetail.fromJson(Map<String, dynamic> json) {
    return ResForMenuDetail(
      status: json['status'],
      menuDetail: MenuDetail.fromJson(json['menudetail']),
    );
  }
}

class MenuDetail {
  String id;
  String dishName;
  String description;
  String kitchenId;
  String price;
  String maxQuantity;
  String photo;
  String video;
  String status;

  MenuDetail({
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

  factory MenuDetail.fromJson(Map<String, dynamic> json) {
    return MenuDetail(
      id: json['id'],
      dishName: json['dishname'],
      description: json['description'],
      kitchenId: json['kitchenid'],
      price: json['full_price'],
      maxQuantity: json['maximum_qauntity'],
      photo: json['photo'],
      video: json['video'],
      status: json['status'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }
}

Future<ResForMenuDetail> getMenuDetail(String itemId) async {
  //print("Mobile: $mob");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menudetail/$itemId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForMenuDetail.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForMenuDetail();
    }
  } else {
    print('Exit');
    return null;
  }
}
