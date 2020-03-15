import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Network {
  Network({this.url});
  String url;

  http.Response _response;

  Future<void> parseInfo() async {
    try {
      _response = await http.get(url);
      convert.jsonDecode(_response.body);
    } catch (e) {
      print(e);
      if (_response.statusCode != 200) {
        print('Error: response status code is not successful - (200)');
      }
    }
  }

  Future<dynamic> getJsonData() async {
    return convert.jsonDecode(_response.body);
  }

  Future<http.Response> getRepsonse() async {
    return _response;
  }
}
