import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForAddOffer {
  int status;
  String message;

  ResForAddOffer({
    this.status,
    this.message,
  });

  factory ResForAddOffer.fromJson(Map<String, dynamic> json) {
    return ResForAddOffer(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForAddOffer> getAddOfferData(
  String title,
  String discount,
  String kitchenId,
  String validDate,
  String product,
  String offerDes,
  String backgroundImage,
) async {
  //print("Mobile: $mob");
  print("Title: $title");
  print("Discount: $discount");
  print("KitchenId: $kitchenId");
  print("Valid Date: $validDate");
  print("Product: $product");
  print("Offer Description: $offerDes");
  print("Image: $backgroundImage");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/addoffer");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "title": title,
          "discount": discount,
          "kitchenid": kitchenId,
          "valid": validDate,
          "selectproduct": product,
          "offer_description": offerDes,
          "image": backgroundImage,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForAddOffer.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForAddOffer();
    }
  } else {
    print('Exit');
    return null;
  }
}
