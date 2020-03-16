import 'package:flutter/material.dart';
import 'package:gta5rp_app/pageParser.dart';
import 'package:gta5rp_app/statics.dart';
import 'package:http/http.dart' as http;

class UserStatsPage extends StatefulWidget {
  static String id = 'user_stats_page';
  @override
  _UserStatsPageState createState() => _UserStatsPageState();
}

class _UserStatsPageState extends State<UserStatsPage> {
  http.Client client;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RaisedButton(
            onPressed: () async => await _getUserStats(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Text('ВОЙТИ'),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            color: Color(0xff3D3D3D),
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }

  _getUserStats() async {
    client = new http.Client();
    try {
      String _accessKey = await _getGTA5RPKey(client);
      print('----------------------------------------');
      print(_accessKey);
      print('----------------------------------------');
      final response = await client.get(
          'https://gta5rp.com/login?_ajax=0&act=do_login&from=login&hash=$_accessKey&name=netsa&needNewBar=1&password=den2412&remember=0&to=',
          headers: Statics.loginHeaders);

      print('-------------RESPONSE LOCATION--------------');
      print(response.headers['location']);
      print('--------------------------------------------');
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  _getGTA5RPKey(http.Client client) async {
    final parser = PageParser(url: 'http://gta5rp.com/stats');
    if (!(await parser.parseData(client))) return;
    final title = parser.document().getElementsByTagName('button');
    return title[5].outerHtml.substring(80, 98);
  }
}

/*

      final response = await client.get(
          'http://gta5rp.com/login?_ajax=0&act=do_login&from=login&hash=1fe77f3b1fd8d2c165&name=netsa&needNewBar=1&password=den2412&remember=0&to=',
          headers: Statics.loginHeaders);
      
      print(response.body);

*/
