import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForAddMenu {
  int status;
  String message;

  ResForAddMenu({
    this.status,
    this.message,
  });

  factory ResForAddMenu.fromJson(Map<String, dynamic> json) {
    return ResForAddMenu(
      status: json['status'],
      message: json['message'],
    );
  }
}

Future<ResForAddMenu> getAddMenuData(
    String dishName,
    description,
    fullprice,
    halfprice,
    kitchenId,
    priceType,
    category,
    maxQuantity,
    photo,
    video,
    specialItemDate,
    List<String> days) async {
  //print("Mobile: $mob");
  print("DishName: $dishName");
  print("Description: $description");
  print("Full Price: $fullprice");
  print("Half Price: $halfprice");
  print("KitchenId: $kitchenId");
  print("PriceType: $priceType");
  print("Category: $category");
  print("MaxQuantity: $maxQuantity");
  print("Video: $video");
  print("Photo: $photo");
  print("Special Item Date: $specialItemDate");
  print("Days: $days");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/menu");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "dishname": dishName,
          "description": description,
          "kitchenid": kitchenId,
          "full_price": fullprice,
          "half_price": halfprice,
          "price_type": priceType,
          "category": category,
          "maximum_qauntity": maxQuantity,
          "photo": photo,
          "video": "video",
          "food_type": "Veg",
          "date": specialItemDate,
          "days": days,
        },
      ));
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForAddMenu.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForAddMenu();
    }
  } else {
    print('Exit');
    return null;
  }
}
