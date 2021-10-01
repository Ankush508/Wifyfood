import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForOffersList> offersListFromJson(String list) =>
    List<ResForOffersList>.from(
      json.decode(list).map(
            (x) => ResForOffersList.fromJson(x),
          ),
    );
String offersListToJson(List<ResForOffersList> topPickList) => json.encode(
      List<dynamic>.from(
        topPickList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForOffersList {
  int status;
  List<CurrentOffer> currentOffer;
  List<ClosedOffer> closedOffer;
  //List<Special> special;

  ResForOffersList({
    this.status,
    this.currentOffer,
    this.closedOffer,
  });

  factory ResForOffersList.fromJson(Map<String, dynamic> json) {
    return ResForOffersList(
      status: json['status'],
      currentOffer: List<CurrentOffer>.from(
          json["Currentoffer"].map((x) => CurrentOffer.fromJson(x))),
      closedOffer: List<ClosedOffer>.from(
          json["Closedoffer"].map((x) => ClosedOffer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Currentoffer": List<dynamic>.from(currentOffer.map((x) => x.toJson())),
        "Closedoffer": List<dynamic>.from(closedOffer.map((x) => x.toJson())),
      };
}

class CurrentOffer {
  String id;
  String kitchenId;
  String title;
  String discount;
  String valid;
  String selectProd;
  String offDes;
  String image;

  CurrentOffer({
    this.id,
    this.kitchenId,
    this.title,
    this.discount,
    this.valid,
    this.selectProd,
    this.offDes,
    this.image,
  });

  factory CurrentOffer.fromJson(Map<String, dynamic> json) {
    return CurrentOffer(
      id: json['id'],
      kitchenId: json['kitchenid'],
      title: json['title'],
      discount: json['discount'],
      valid: json['valid'],
      selectProd: json['selectproduct'],
      offDes: json['offer_description'],
      image: json['image'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "kitchenid": kitchenId,
        "title": title,
        "discount": discount,
        "valid": valid,
        "selectproduct": selectProd,
        "offer_description": offDes,
        "image": image,
      };
}

class ClosedOffer {
  String id;
  String kitchenId;
  String title;
  String discount;
  String valid;
  String selectProd;
  String offDes;
  String image;

  ClosedOffer({
    this.id,
    this.kitchenId,
    this.title,
    this.discount,
    this.valid,
    this.selectProd,
    this.offDes,
    this.image,
  });

  factory ClosedOffer.fromJson(Map<String, dynamic> json) {
    return ClosedOffer(
      id: json['id'],
      kitchenId: json['kitchenid'],
      title: json['title'],
      discount: json['discount'],
      valid: json['valid'],
      selectProd: json['selectproduct'],
      offDes: json['offer_description'],
      image: json['image'],
      //data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "kitchenid": kitchenId,
        "title": title,
        "discount": discount,
        "valid": valid,
        "selectproduct": selectProd,
        "offer_description": offDes,
        "image": image,
      };
}

Future<ResForOffersList> getOfferList(String kitchenId) async {
  var link = Uri.parse("https://wifyfood.com/api/kitchen/offerlist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForOffersList.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForOffersList();
    }
  } else {
    print('Exit');
    return null;
  }
}

Future<List<CurrentOffer>> getCurrentOfferData(String kitchenId) async {
  List<CurrentOffer> currentOffer;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/offerlist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  // print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["Currentoffer"] as List;
    //print("Rest: $rest");
    try {
      currentOffer = rest
          .map<CurrentOffer>((json) => CurrentOffer.fromJson(json))
          .toList();
    } catch (e) {
      currentOffer = [];
    }
    //print('List Size: ${topPickList.length}');

    return currentOffer;
  } else {
    print('Exit');
    return null;
  }
}

Future<List<ClosedOffer>> getClosedOfferData(String kitchenId) async {
  List<ClosedOffer> closedOffer;
  var link = Uri.parse("https://wifyfood.com/api/kitchen/offerlist/$kitchenId");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["Closedoffer"] as List;
    //print("Rest: $rest");
    try {
      closedOffer =
          rest.map<ClosedOffer>((json) => ClosedOffer.fromJson(json)).toList();
    } catch (e) {
      closedOffer = [];
    }
    //print('List Size: ${promotedkitchenList.length}');

    return closedOffer;
  } else {
    print('Exit');
    return null;
  }
}
