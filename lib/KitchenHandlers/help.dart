import 'dart:convert';
import 'package:http/http.dart' as http;

class ResForHelp {
  int responseCode;
  Response response;

  ResForHelp({
    this.responseCode,
    this.response,
  });

  factory ResForHelp.fromJson(Map<String, dynamic> json) {
    return ResForHelp(
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

Future<ResForHelp> getHelpData() async {
  // print("kid: $kid");
  var link = Uri.parse("https://wifyfood.com/api/kitchen/help");
  http.Response res = await http.get(
    link,
  );
  //print('Response of Profile Data: ${res.body}');
  if (res.statusCode == 200) {
    try {
      return ResForHelp.fromJson(jsonDecode(res.body));
    } catch (e) {
      return ResForHelp();
    }
  } else {
    print('Exit');
    return null;
  }
}
