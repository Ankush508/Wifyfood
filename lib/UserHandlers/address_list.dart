import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForAddressList> addressListFromJson(String list) =>
    List<ResForAddressList>.from(
      json.decode(list).map(
            (x) => ResForAddressList.fromJson(x),
          ),
    );
String addressListToJson(List<ResForAddressList> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForAddressList {
  int status;
  List<Data> data;

  ResForAddressList({
    this.status,
    this.data,
  });

  factory ResForAddressList.fromJson(Map<String, dynamic> json) {
    return ResForAddressList(
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
  String userid;
  String location;
  String address;
  String landmark;
  String addressType;

  Data({
    this.id,
    this.userid,
    this.location,
    this.address,
    this.landmark,
    this.addressType,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userid: json['user_id'],
      location: json['location'],
      address: json['address'],
      landmark: json['landmark'],
      addressType: json['addresstype'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userid,
        "location": location,
        "address": address,
        "landmark": landmark,
        "addresstype": addressType,
      };
}

Future<ResForAddressList> getAddressList(String userId) async {
  print(userId);
  var link = Uri.parse("https://wifyfood.com/api/users/addresslist/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForAddressList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<Data>> getAddressListData(String userId) async {
  List<Data> addressList;
  var link = Uri.parse("https://wifyfood.com/api/users/addresslist/$userId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["data"] as List;
    //print("Rest: $rest");
    addressList = rest.map<Data>((json) => Data.fromJson(json)).toList();
    //print('List Size: ${addressList.length}');

    return addressList;
  } else {
    print('Exit');
    return null;
  }
}
