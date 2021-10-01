import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForFavoriteKitchen {
  int status;
  String message;

  ResForFavoriteKitchen({
    this.status,
    this.message,
  });

  factory ResForFavoriteKitchen.fromJson(Map<String, dynamic> json) {
    return ResForFavoriteKitchen(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForFavoriteKitchen> getFavoriteKitchenData(
  String userId,
  String kitchenId,
  String status,
) async {
  print("UserId: $userId");
  print("KitchenId: $kitchenId");
  print("Favorite: $status");
  var link = Uri.parse("https://wifyfood.com/api/users/favorite_kitchen");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "user_id": userId,
          "kitchen_id": kitchenId,
          "status": status,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForFavoriteKitchen.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
