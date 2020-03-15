import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gta5rp_app/pageParser.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class UserStatsPage extends StatefulWidget {
  static String id = 'user_stats_page';
  @override
  _UserStatsPageState createState() => _UserStatsPageState();
}

class _UserStatsPageState extends State<UserStatsPage> {
  @override
  void initState() {
    super.initState();
    _getUserStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RaisedButton(
                      onPressed: () async => await _getUserStats(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        child: Text('ВОЙТИ'),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      color: Color(0xff3D3D3D),
                      textColor: Colors.white,
                    ),
        ),
      ),
    );
  }

  _getUserStats() async {
    var client = http.Client();
    try {
      String _accessKey = await _getGTA5RPKey(client);
      print('ACCESS POINT: ' + 'http://gta5rp.com/login?_ajax=0&act=do_login&from=login&hash=$_accessKey&name=netsa&needNewBar=1&password=den2412&remember=0&to=');
      var response = await client.get(
          'http://gta5rp.com/login?_ajax=0&act=do_login&from=login&hash=$_accessKey&name=netsa&needNewBar=1&password=den2412&remember=0&to=',
          headers: {
           'Sec-Fetch-Dest' : 'empty',
           'X-Requested-With' : 'XMLHttpRequest',
           'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
           'DNT' : '1',
           'Content-Type' : 'application/x-www-form-urlencoded',
           'Accept' : '*/*'});
      print('-------------------REQUEST------------------------');
      response.request.headers.forEach((i, j) {
        print(i + " : " + j);
      });
      print('-------------------RESPONSE------------------------');
            response.headers.forEach((i, j) {
        print(i + " : " + j);
      });
      client.close();
    } catch (e) {
      print(e);
    }
  }

  _getGTA5RPKey(http.Client client) async {
    final parser = PageParser(url: 'https://gta5rp.com/login');
    if(!(await parser.parseData(client))) return;
    final title = parser.document().getElementsByTagName('button');
    return title[5].outerHtml.substring(80, 99);
  }
}
