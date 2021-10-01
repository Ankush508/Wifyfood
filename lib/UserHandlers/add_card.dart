import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForAddCard {
  int status;
  String message;

  ResForAddCard({
    this.status,
    this.message,
  });

  factory ResForAddCard.fromJson(Map<String, dynamic> json) {
    return ResForAddCard(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForAddCard> getAddCardData(String userId, String cardNo,
    String validDate, String cvv, String nameOnCard, String consent) async {
  //print("Mobile: $mob");
  var link = Uri.parse("https://wifyfood.com/api/users/addcard");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "user_id": userId,
          "card_number": cardNo,
          "valid_through_date": validDate,
          "cvv": cvv,
          "name_of_cart": nameOnCard,
          "consent": consent,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForAddCard.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForAddCard();
    }
  } else {
    print('Exit');
    return null;
  }
}
