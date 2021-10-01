import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForAboutWifyfood {
  int responseCode;
  Response response;

  ResForAboutWifyfood({
    this.responseCode,
    this.response,
  });

  factory ResForAboutWifyfood.fromJson(Map<String, dynamic> json) {
    return ResForAboutWifyfood(
      responseCode: json['RESPONSECODE'],
      response: Response.fromJson(json['RESPONSE']),
    );
  }
}

class Response {
  String id;
  String title;
  String content;
  String image;

  Response({
    this.id,
    this.title,
    this.content,
    this.image,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }
}

Future<ResForAboutWifyfood> getAboutWifyfoodData() async {
  // print("kid: $kid");
  var link = Uri.parse("https://wifyfood.com/api/users/about");
  http.Response res = await http.get(
    link,
  );
  //print('Response of Profile Data: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForAboutWifyfood.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForAboutWifyfood();
    }
  } else {
    print('Exit');
    return null;
  }
}
