import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({required this.url, required this.headers});
  late String url;

  late Map<String, String> headers;

  Future<dynamic> getData() async {
    try {
      Future<http.Response> fetchAPI() async {
        return http.get(Uri.parse(url), headers: headers);
      }

      var data = await fetchAPI();

      if (data.statusCode != 200) {
        print(data.statusCode);
      }
      return jsonDecode(data.body);
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
