import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForCart> cartFromJson(String list) => List<ResForCart>.from(
      json.decode(list).map(
            (x) => ResForCart.fromJson(x),
          ),
    );
String cartToJson(List<ResForCart> list) => json.encode(
      List<dynamic>.from(
        list.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForCart {
  int status;
  List<Cart> cart;
  var orderPrice;
  var cartTotal;
  var taxCharge;
  var orderDiscount;
  var deliveryCharge;
  var packCharge;
  var baseDelCharge;
  var distanceCharge;
  String kitchenName;
  var adminCharge;
  String kitchenId;
  String totalQuantity;
  String logo;
  String email;

  ResForCart({
    this.status,
    this.cart,
    this.orderPrice,
    this.cartTotal,
    this.taxCharge,
    this.orderDiscount,
    this.deliveryCharge,
    this.packCharge,
    this.baseDelCharge,
    this.distanceCharge,
    this.kitchenName,
    this.adminCharge,
    this.kitchenId,
    this.totalQuantity,
    this.logo,
    this.email,
  });

  factory ResForCart.fromJson(Map<String, dynamic> json) {
    return ResForCart(
      status: json['status'],
      cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
      orderPrice: json['orderprice'],
      cartTotal: json['carttotalafteradmincharge'],
      taxCharge: json['tax_charge'],
      orderDiscount: json['orderdiscount'],
      deliveryCharge: json['delivery_charges'],
      packCharge: json['package_charge'],
      baseDelCharge: json['base_delivery_charge'],
      distanceCharge: json['distance_charge'],
      kitchenName: json['kitchen_name'],
      adminCharge: json['admincharge'],
      logo: json['logo'],
      email: json['location'],
      kitchenId: json['kitchen_id'],
      totalQuantity: json['order_quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "orderprice": orderPrice,
        "carttotal": cartTotal,
        "tax_charge": taxCharge,
        "orderdiscount": orderDiscount,
        "delivery_charges": deliveryCharge,
        "package_charge": packCharge,
        "base_delivery_charge": baseDelCharge,
        "distance_charge": distanceCharge,
        "kitchen_name": kitchenName,
        "admincharge": adminCharge,
        "logo": logo,
        "location": email,
        "kitchen_id": kitchenId,
        "order_quantity": totalQuantity,
      };
}

class Cart {
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
  String kitchenName;
  String orderQuantity;
  String orderPrice;
  String cartid;

  Cart({
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
    this.kitchenName,
    this.orderQuantity,
    this.orderPrice,
    this.cartid,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      dishName: json['dishname'],
      kitchenId: json['kitchen_id'],
      foodType: json['food_type'],
      category: json['category'],
      halfPrice: json['half_price'],
      fullPrice: json['full_price'],
      maxQuantity: json['maximum_quantity'],
      photo: json['photo'],
      video: json['video'],
      status: json['status'],
      kitchenName: json['kitchen_name'],
      orderQuantity: json['orderquantity'],
      orderPrice: json['orderprice'],
      cartid: json['cartid'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "dishname": dishName,
        "description": description,
        "kitchen_id": kitchenId,
        "food_type": foodType,
        "category": category,
        "full_price": fullPrice,
        "half_price": halfPrice,
        "maximum_qauntity": maxQuantity,
        "photo": photo,
        "video": video,
        "status": status,
        "kitchen_name": kitchenName,
        "orderquantity": orderQuantity,
        "orderprice": orderPrice,
        "cartid": cartid
      };
}

Future<ResForCart> getCart(String userId) async {
  var link = Uri.parse("https://wifyfood.com/api/users/cart/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForCart.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<Cart>> getCartData(String userId) async {
  List<Cart> cart;
  var link = Uri.parse("https://wifyfood.com/api/users/cart/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["cart"] as List;
    //print("Rest: $rest");
    cart = rest.map<Cart>((json) => Cart.fromJson(json)).toList();
    //print('CartList Size: ${cart.length}');

    return cart;
  } else {
    print('Exit');
    return null;
  }
}
