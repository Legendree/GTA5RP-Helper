import 'package:flutter/material.dart';
import 'package:gta5rp_app/header_card.dart';
import 'package:gta5rp_app/pageParser.dart';
import 'package:gta5rp_app/statics.dart';
import 'package:http/http.dart' as http;

enum Server {
  Downtown,
  Strawberry,
  Vinewood,
  Blackberry,
  Insquad,
  Sunrise
}

class UserStatsPage extends StatefulWidget {
  static String id = 'user_stats_page';
  @override
  _UserStatsPageState createState() => _UserStatsPageState();
}

class _UserStatsPageState extends State<UserStatsPage> {

  http.Client client;
  String serverToAccess = '';
  var accessCookie;

  Map<String, String> userData = {};

  @override
  void initState() {
    super.initState();
    client = new http.Client();
    _getUserStats();
  }

  @override
  void dispose() {
    if(client != null)
      client.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: _getUserStats(),
                builder: (context, snapshot) {
                  var name = '';
                  var dp = '';
                  if(snapshot.data == null) {
                    name = 'Loading...';
                    dp = '???';
                  }
                  else if (snapshot.data) {
                    name = userData['name'];
                    dp = userData['dp'];
                  }
                  return HeaderCard(dp: name, name: dp);
                }
              ),
              //HeaderCard(dp: userData['dp'], name: userData['name'].toUpperCase()),
              FutureBuilder(
                future: _getUserStats(),
                builder: (context, snapshot) {
                  if(snapshot.data == null) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(itemBuilder: (context, index) {
                  });
                },
              )
            ],
          )
        ),
      ),
    );
  }

  _getUserStats() async {
    try {
      String _accessKey = await _getGTA5RPKey(client);
      print('----------------------------------------');
      print(_accessKey);
      print('----------------------------------------');
         
      final url = 'https://gta5rp.com/login?_ajax=0&act=do_login&from=login&hash=' + _accessKey + '&name=netsa&needNewBar=1&password=den2412&remember=0&to=';
      print(url);
      final login = await client.post(url, headers: Statics.loginHeaders);
      print('-------------RESPONSE LOCATION--------------');
      print(login.headers['location']);
      print('--------------------------------------------');

      final safeLogin = await client.post(login.headers['location'], headers: Statics.loginHeaders);

      //print('-------------RESPONSE LOCATION--------------');
      //print(safeLogin.headers['set-cookie']);
      //print('--------------------------------------------');

      String _setCookie = safeLogin.headers['set-cookie'].substring(0, 59);
      Map<String, String> localSafeLoginHeader = Statics.loginHeaders;
      localSafeLoginHeader['Cookie'] += '; ' + _setCookie;
      accessCookie = localSafeLoginHeader;

      //final stats = await client.get(safeLogin.headers['location'], headers: localSafeLoginHeader);

      final parser = PageParser(url: safeLogin.headers['location']);
      if (!(await parser.parseData(client, localSafeLoginHeader))) return;
      //final title = parser.document().getElementsByClassName('accountInfo__name')
      //  .forEach((f) => print(f.text));
      final name = parser.document().getElementsByClassName('accountInfo__name');
      //print(name[0].text.trim());
      final dp = parser.document().getElementsByClassName('accountInfo__score');
      //print(dp[0].text.trim().substring(5).trim());
      final characters = parser.document().getElementsByClassName('playerInfo__card gradient__box ucp__playerInfo ucp__playerInfo--gradient');
      
      List characterInfo = [];
      characters.forEach((character) {
      character.text.replaceAll(' ', '').split('\n')
        .forEach((f) {
          if(f.isNotEmpty) characterInfo.add(f);
        });    
      characterInfo.forEach((f) => print(f));
      });

/*
      List characterInfo = [];
      characters[0].text.replaceAll(' ', '').split('\n')
        .forEach((f) {
          if(f.isNotEmpty) characterInfo.add(f);
        });    
      characterInfo.forEach((f) => print(f));
*/
      setState(() {
        userData['name'] = name[0].text.trim();
        userData['dp'] = dp[0].text.trim().substring(5).trim();
      });

    } catch (e) {
      print(e);
    }
  }

  _getGTA5RPKey(http.Client client) async {
    final parser = PageParser(url: 'http://gta5rp.com/login/');
    if (!(await parser.parseData(client, Statics.parseHeaders))) return;
    final title = parser.document().getElementsByTagName('button');
    return title[5].outerHtml.substring(80, 98);
  }

  _getServerData(Server server) async {
    final parser = PageParser(url: _getServerUrl(server));
    if (!(await parser.parseData(client, accessCookie))) return;
    //final title = parser.document().getElementsByClassName('accountInfo__name')
    //  .forEach((f) => print(f.text));
    final accountInfoName = parser.document().getElementsByClassName('accountInfo__name');
    print(accountInfoName[0].text.trim());
  }

  _getServerUrl(Server server) {
    switch(server) {
      case Server.Blackberry: return 'https://gta5rp.com/stats?act=switch_server&sid=04&to=_lnnh2CehKNJL3N0YXRz';
      case Server.Downtown: return 'https://gta5rp.com/stats?act=switch_server&sid=01&to=_lnnh2CehKNJL3N0YXRz';
      case Server.Insquad: return 'https://gta5rp.com/stats?act=switch_server&sid=05&to=_lnnh2CehKNJL3N0YXRz';
      case Server.Sunrise: return 'https://gta5rp.com/stats?act=switch_server&sid=06&to=_lnnh2CehKNJL3N0YXRz';
      case Server.Vinewood: return 'https://gta5rp.com/stats?act=switch_server&sid=03&to=_lnnh2CehKNJL3N0YXRz';
      case Server.Strawberry: return 'https://gta5rp.com/stats?act=switch_server&sid=02&to=_lnnh2CehKNJL3N0YXRz';
      default: return 'https://gta5rp.com/stats';
    }
  }
}

/*
RaisedButton(
            onPressed: () async => null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Text('ВОЙТИ'),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            color: Color(0xff3D3D3D),
            textColor: Colors.white,
          ),
*/
