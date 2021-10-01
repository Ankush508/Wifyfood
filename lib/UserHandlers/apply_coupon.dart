import 'dart:convert';
import 'package:http/http.dart' as http;

class ApplyCoupon {
  int status;
  String couponAmount;
  String couponValue;
  String response;
  TotalAmount total;
  String totalAfterCouponApply;
  // String tax;
  // String totalSum;
  // String taxValue;

  ApplyCoupon({
    this.status,
    this.couponAmount,
    this.couponValue,
    this.response,
    this.total,
    // this.tax,
    this.totalAfterCouponApply,
    // this.totalSum,
    // this.taxValue,
  });

  factory ApplyCoupon.fromJson(Map<String, dynamic> json) {
    return ApplyCoupon(
      status: json['status'],
      couponAmount: json['couponamount'],
      couponValue: json['couponvalue'],
      response: json['response'],
      total: TotalAmount.fromJson(json['totalamount']),
      totalAfterCouponApply: json['totalsumaftercoupon'],
      // tax: json['tax'],
      // totalSum: json['totalsum'],
      // taxValue: json['taxvalue'],
    );
  }
}

class TotalAmount {
  String totalAmount;

  TotalAmount({
    this.totalAmount,
  });

  factory TotalAmount.fromJson(Map<String, dynamic> json) {
    return TotalAmount(
      totalAmount: json['totalamount'],
    );
  }

  Map<String, dynamic> toJson() => {
        "totalamount": totalAmount,
      };
}

Future<ApplyCoupon> postApplyCoupon(String code, String userId) async {
  print("Coupon Code: $code");
  print("User Id: $userId");
  var link = Uri.parse("https://wifyfood.com/api/users/coupon_applied");
  http.Response res = await http.post(link,
      body: jsonEncode(
        {
          "coupon_code": code,
          "user_id": userId,
        },
      ));
  print('Response: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ApplyCoupon.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ApplyCoupon();
    }
  } else {
    print('Exit');
    return ApplyCoupon(status: 0, response: "Something went wrong!");
  }
}
