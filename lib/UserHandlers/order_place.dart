import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForOrderPlace {
  int status;
  String message;

  ResForOrderPlace({
    this.status,
    this.message,
  });

  factory ResForOrderPlace.fromJson(Map<String, dynamic> json) {
    return ResForOrderPlace(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForOrderPlace> getOrderPlaceData(
    String userId,
    String kitchenId,
    String addressId,
    String quantity,
    String orderTotal,
    String totalDiscount,
    String delCharge,
    String payType,
    List itemId) async {
  //print("Mobile: $mob");
  print("User Id: $userId");
  print("Kitchen Id: $kitchenId");
  print("Address Id: $addressId");
  print("Quantity: $quantity");
  print("Order Total: $orderTotal");
  print("Total Discount: $totalDiscount");
  print("Delivery Charge: $delCharge");
  print("Payment Type: $payType");
  print("Items Id's: $itemId");
  var link = Uri.parse("https://wifyfood.com/api/users/orderplace");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          // "user_id": userId,
          // "kitchen_id": kitchenId,
          // "address_id": addressId,
          // "quantity": quantity,
          // "price": orderTotal,
          // "total_discount": totalDiscount,
          // "delivery_charge": "0",
          // "total_price": orderTotal,
          // "payment_type": (payType == "Offline") ? "1" : "2",
          // "item_id": itemId,
          "user_id": userId,
          "tid": "123456789",
          "tracking_id": "23456789",
          "bank_ref_no": "2345678",
          "address_id": addressId,
          "quantity": quantity,
          "price": orderTotal,
          "total_discount": totalDiscount,
          "item_total": orderTotal,
          "packaging_charge": "0",
          "tax_charge": "0",
          "admin_charge": "0",
          "delivery_charge": "0",
          "total_price": orderTotal,
          "payment_type": (payType == "Offline") ? "1" : "2",
          "item_id": itemId,
          "kitchen_id": kitchenId,
        },
      ));
  print("New Order Place API");
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForOrderPlace.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
