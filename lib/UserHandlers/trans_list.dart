import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForTransactionList> transListFromJson(String list) =>
    List<ResForTransactionList>.from(
      json.decode(list).map(
            (x) => ResForTransactionList.fromJson(x),
          ),
    );
String transListToJson(List<ResForTransactionList> menuList) => json.encode(
      List<dynamic>.from(
        menuList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForTransactionList {
  int status;
  String response;
  List<TransactionList> transList;

  ResForTransactionList({
    this.status,
    this.response,
    this.transList,
  });

  factory ResForTransactionList.fromJson(Map<String, dynamic> json) {
    return ResForTransactionList(
      status: json['status'],
      response: json['response'],
      transList: List<TransactionList>.from(
          json["transactionlist"].map((x) => TransactionList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "transactionlist": List<dynamic>.from(transList.map((x) => x.toJson())),
      };
}

class TransactionList {
  String id;
  String orderId;
  String userId;
  String kitchenId;
  String transAmount;
  String dateTime;
  String payMode;
  String kitchenName;
  String status;

  TransactionList({
    this.id,
    this.orderId,
    this.userId,
    this.transAmount,
    this.dateTime,
    this.kitchenId,
    this.payMode,
    this.status,
    this.kitchenName,
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    return TransactionList(
      id: json['id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      kitchenId: json['kitchen_id'],
      transAmount: json['transaction_amount'],
      dateTime: json['date_time'],
      payMode: json['payment_mode'],
      kitchenName: json['kitchen_name'],
      status: json['status'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "transaction_amount": transAmount,
        "date_time": dateTime,
        "kitchen_id": kitchenId,
        "payment_mode": payMode,
        "status": status,
        "kitchen_name": kitchenName,
      };
}

Future<ResForTransactionList> getTransList(String userId) async {
  // TODO
  var link = Uri.parse("https://wifyfood.com/api/users/transaction_list/1");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForTransactionList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<TransactionList>> getTransListData(String userId) async {
  List<TransactionList> menuList;
  // TODO
  var link = Uri.parse("https://wifyfood.com/api/users/transaction_list/1");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["transactionlist"] as List;
    //print("Rest: $rest");
    menuList = rest
        .map<TransactionList>((json) => TransactionList.fromJson(json))
        .toList();
    //print('List Size: ${menuList.length}');
    return menuList;
  } else {
    print('Exit');
    return null;
  }
}
