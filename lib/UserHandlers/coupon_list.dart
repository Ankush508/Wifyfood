import 'dart:convert';
import 'package:http/http.dart' as http;

List<ResForCouponList> dashboardUserListFromJson(String list) =>
    List<ResForCouponList>.from(
      json.decode(list).map(
            (x) => ResForCouponList.fromJson(x),
          ),
    );
String dashboardUserListToJson(List<ResForCouponList> topPickList) =>
    json.encode(
      List<dynamic>.from(
        topPickList.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForCouponList {
  int status;
  List<CouponDetail> couponDetail;
  String response;

  ResForCouponList({
    this.status,
    this.couponDetail,
    this.response,
  });

  factory ResForCouponList.fromJson(Map<String, dynamic> json) {
    return ResForCouponList(
      status: json['status'],
      couponDetail: List<CouponDetail>.from(
          json["coupondetail"].map((x) => CouponDetail.fromJson(x))),
      response: json['response'],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "coupondetail": List<dynamic>.from(couponDetail.map((x) => x.toJson())),
        // "promoted": List<dynamic>.from(promoted.map((x) => x.toJson())),
        // "special_offer": List<dynamic>.from(special.map((x) => x.toJson())),
      };
}

class CouponDetail {
  String id;
  String imageData;
  CouponDetail({
    this.id,
    this.imageData,
  });

  factory CouponDetail.fromJson(Map<String, dynamic> json) {
    return CouponDetail(
      id: json['id'],
      imageData: json['image_data'],
      // firstName: json['f_name'],
      // lastName: json['l_name'],
      // image: json['image'],
      // email: json['email'],
      // password: json['password'],
      // mobileNumber: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_data": imageData,
        // "owner_name": ownerName,
        // "owner_dob": ownerDob,
        // "kitchen_name": kitchenName,
        // "cuisine": cuisine,
        // "email": email,
        // "location": location,
        // "latitude": latitude,
        // "longitude": longitude,
        // "pincode": pincode,
        // "mobile": mobile,
        // "logo": logo,
        // "otp": otp,
        // "password": password,
        // "device_id": deviceId,
        // "status": status,
        // "type": type,
        // "onlineoffline": onOff,
        // "banner_image": bannerImage,
        // "rating": rating,
        // "favorite_kitchen": fav,
      };
}

Future<List<CouponDetail>> getCouponList(String lat, String long) async {
  print("Coupon Offer Latitude: $lat");
  print("Coupon Offer Longitude: $long");
  List<CouponDetail> couponList;
  var link = Uri.parse("https://wifyfood.com/api/users/coupon_list");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          'latitude': lat,
          'longitude': long,
        },
      ));
  //var rest = res.body;
  //print('Rest: $rest');
  //print(rest.length);
  print("**************************");
  if (res.statusCode == 200) {
    try {
      var body = jsonDecode(res.body);
      var rest = body["coupondetail"] as List;
      //print("Rest: $rest");
      couponList = rest
          .map<CouponDetail>((json) => CouponDetail.fromJson(json))
          .toList();
      //print('List Size: ${topPickList.length}');

      return couponList;
    } catch (e) {
      return couponList = [];
    }
  } else {
    print('Exit Coupon Offer');
    return null; //topPickList = [];
  }
}
