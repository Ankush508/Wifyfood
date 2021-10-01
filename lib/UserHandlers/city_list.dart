import 'dart:convert';

import 'package:http/http.dart' as http;

List<ResForCityList> cityListFromJson(String list) => List<ResForCityList>.from(
      json.decode(list).map(
            (x) => ResForCityList.fromJson(x),
          ),
    );
String cityListToJson(List<ResForCityList> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ResForCityList {
  int status;
  String response;
  List<City> city;

  ResForCityList({
    this.status,
    this.response,
    this.city,
  });

  factory ResForCityList.fromJson(Map<String, dynamic> json) {
    return ResForCityList(
      status: json['status'],
      response: json['response'],
      city: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "cities": List<dynamic>.from(city.map((x) => x.toJson())),
      };
}

class City {
  String cityId;
  String cityName;

  City({
    this.cityId,
    this.cityName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['city_id'],
      cityName: json['city_name'],
      //data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
      };
}

Future<ResForCityList> getCityList() async {
  var link = Uri.parse("https://wifyfood.com/api/users/city_list");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    return ResForCityList.fromJson(jsonDecode(res.body));
  } else {
    print('Exit');
    return null;
  }
}

Future<List<City>> getCityListData() async {
  List<City> cityList;
  var link = Uri.parse("https://wifyfood.com/api/users/city_list");
  http.Response res = await http.get(
    link,
  );
  //print('Response: ${res.body}');
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    var rest = body["cities"] as List;
    //print("Rest: $rest");
    cityList = rest.map<City>((json) => City.fromJson(json)).toList();
    //print('List Size: ${cityList.length}');

    return cityList;
  } else {
    print('Exit');
    return null;
  }
}
