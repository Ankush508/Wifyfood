import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForRemoveItem {
  int status;
  String data;

  ResForRemoveItem({
    this.status,
    this.data,
  });

  factory ResForRemoveItem.fromJson(Map<String, dynamic> json) {
    return ResForRemoveItem(
      status: json['status'],
      data: json['data'],
    );
  }
}

Future<ResForRemoveItem> getRemoveData(String userId, String itemId) async {
  print("User Id: $userId");
  print("Item Id: $itemId");
  var link = Uri.parse("https://wifyfood.com/api/users/removeitem/$itemId");
  http.Response res = await http.get(
    link,
  );
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForRemoveItem.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
