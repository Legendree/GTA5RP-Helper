import 'package:flutter/material.dart';
import 'package:gta5rp_app/input_field.dart';
import 'package:gta5rp_app/pageParser.dart';
import 'package:gta5rp_app/statics.dart';
import 'package:gta5rp_app/user_stats.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  http.Client _client;
  bool _spinner;

  String _loggin;
  String _password;

  @override
  void initState() {
    super.initState();
    _client = new http.Client();
    _spinner = false;
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _spinner,
          progressIndicator: CircularProgressIndicator(),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png'),
              SizedBox(height: 40),
              InputField(
                    hintText: 'Логин',
                    onChanged: (value) {
                      _loggin = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  InputField(
                    hintText: 'Пароль',
                    isObscure: true,
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 25),
              RaisedButton(
                onPressed: () async {
                  setState(() {
                    _spinner = true;
                  });
                  final parsedDocument = await _parseStatsPage();
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserStatsPage(document: parsedDocument)));
                  //Navigator.pop(context, true);
                  setState(() {
                    _spinner = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text('ВОЙТИ'),
                ),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                color: Color(0xff3D3D3D),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<dom.Document> _parseStatsPage() async {
    try {
      String _accessKey = await _getGTA5RPKey(_client);
      print('----------------------------------------');
      print(_accessKey);
      print('----------------------------------------');

      final url =
          'https://gta5rp.com/login?_ajax=0&act=do_login&from=login&hash=' +
              _accessKey +
              '&name=<USERNAME>&needNewBar=1&password=<PASSWORD>&remember=0&to=';
      print(url);
      final login = await _client.post(url, headers: Statics.loginHeaders);
      print('-------------RESPONSE LOCATION--------------');
      print(login.headers['location']);
      print('--------------------------------------------');

      final safeLogin = await _client.post(login.headers['location'],
          headers: Statics.loginHeaders);

      //print('-------------RESPONSE LOCATION--------------');
      //print(safeLogin.headers['set-cookie']);
      //print('--------------------------------------------');

      String _setCookie = safeLogin.headers['set-cookie'].substring(0, 59);
      Map<String, String> localSafeLoginHeader = Statics.loginHeaders;
      localSafeLoginHeader['Cookie'] += '; ' + _setCookie;

      //final stats = await client.get(safeLogin.headers['location'], headers: localSafeLoginHeader);

      final parser = PageParser(url: safeLogin.headers['location']);
      if (!(await parser.parseData(_client, localSafeLoginHeader))) return null;

      return parser.document();
    } catch (e) {
      print(e);
      return null;
    }
  }

  _getGTA5RPKey(http.Client client) async {
    final parser = PageParser(url: 'http://gta5rp.com/login/');
    if (!(await parser.parseData(client, Statics.parseHeaders))) return;
    final title = parser.document().getElementsByTagName('button');
    return title[5].outerHtml.substring(80, 98);
  }
}
