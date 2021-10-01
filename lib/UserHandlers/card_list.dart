import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForCardList> addressListFromJson(String list) =>
    List<ResForCardList>.from(
      json.decode(list).map(
            (x) => ResForCardList.fromJson(x),
          ),
    );
String addressListToJson(List<ResForCardList> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForCardList {
  int status;
  List<Data> data;

  ResForCardList({
    this.status,
    this.data,
  });

  factory ResForCardList.fromJson(Map<String, dynamic> json) {
    return ResForCardList(
      status: json['status'],
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  String id;
  String cardNo;
  String validThrough;
  String cvv;
  String userid;
  String nameOnCard;
  String consent;

  Data({
    this.id,
    this.userid,
    this.cardNo,
    this.cvv,
    this.nameOnCard,
    this.validThrough,
    this.consent,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userid: json['user_id'],
      cardNo: json['card_number'],
      validThrough: json['valid_through_date'],
      cvv: json['cvv'],
      nameOnCard: json['name_of_cart'],
      consent: json['consent'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "card_number": cardNo,
        "valid_through_date": validThrough,
        "cvv": cvv,
        "user_id": userid,
        "name_of_cart": nameOnCard,
        "consent": consent,
      };
}

Future<ResForCardList> getCardList(String userId) async {
  var link = Uri.parse("https://wifyfood.com/api/users/cardlist/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForCardList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<Data>> getCardListData(String userId) async {
  List<Data> cardList;
  var link = Uri.parse("https://wifyfood.com/api/users/cardlist/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["data"] as List;
    //print("Rest: $rest");
    cardList = rest.map<Data>((json) => Data.fromJson(json)).toList();
    //print('List Size: ${addressList.length}');

    return cardList;
  } else {
    print('Exit');
    return null;
  }
}
