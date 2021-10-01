import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForAddItem {
  int status;
  String message;

  ResForAddItem({
    this.status,
    this.message,
  });

  factory ResForAddItem.fromJson(Map<String, dynamic> json) {
    return ResForAddItem(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForAddItem> getAddItemData(String userId, String itemId, String price,
    String quantityType, String kitchenId) async {
  print("User Id: $userId");
  print("Item Id: $itemId");
  print("Price: $price");
  print("Quantity Type: $quantityType");
  print("Kitchen Id: $kitchenId");
  var link = Uri.parse("https://wifyfood.com/api/users/additem");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "user_id": userId,
          "item_id": itemId,
          "quantity": quantityType,
          "price": price,
          "kitchen_id": kitchenId,
          "item_quantity": "1"
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForAddItem.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
