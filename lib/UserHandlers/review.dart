import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForReview {
  int status;
  String message;

  ResForReview({
    this.status,
    this.message,
  });

  factory ResForReview.fromJson(Map<String, dynamic> json) {
    return ResForReview(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForReview> getReviewData(
    String userId, String rating, String message, String kitchenId) async {
  //print("Mobile: $mob");
  var link = Uri.parse("https://wifyfood.com/api/users/review");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'user_id': userId,
          'rating': rating,
          'message': message,
          'kitchen_id': kitchenId,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForReview.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}
