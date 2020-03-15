import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class PageParser {
  PageParser({this.url});
  final String url;

  http.Response _response;
  dom.Document _document;

  Future<bool> parseData(http.Client client) async {
    _response = await client.get(url);
    if(_response.statusCode == 200) {
      _document = parser.parse(_response.body);
      print('Parse is done');
      return true;
    }
    print('Parse failed');
    return false;
  }

  dom.Document document() {
    return _document;
  }
}