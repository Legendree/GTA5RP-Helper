import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gta5rp_app/constants.dart';
import 'package:gta5rp_app/login_page.dart';
import 'package:gta5rp_app/network.dart';
import 'package:gta5rp_app/server_card.dart';
import 'package:gta5rp_app/server_data.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Network _network;
  List<ServerData> _serverInfo = [];
  Timer timer;
  int _totalOnline = 0;

  String serverListUrl;

  @override
  void initState() {
    super.initState();
    setState(() {
      serverListUrl = 'https://cdn.rage.mp/master/';
    });
    timer = Timer.periodic(Duration(seconds: 3), (t) => _getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png'),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Color(0xff2C2C2C)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            width: 80,
                            child: Text('СЕРВЕР', style: kHeaderTextStyle)),
                        Container(
                            child: Text('ИГРОКИ', style: kHeaderTextStyle)),
                        Container(
                            child:
                                Text('МАКС. ИГРОКИ', style: kHeaderTextStyle)),
                        Container(child: Text('ЯЗЫК', style: kHeaderTextStyle))
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: _getServerList(),
                  builder: (context, snapshot) {
                    if(snapshot.data == null) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 100),
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    }
                    else if(snapshot.hasError) {
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Divider(
                                color: Color(0xff4F4F4F),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ServerCard(
                                serverName: _getServerName(index),
                                data: ServerData(
                                  players: 0,
                                  maxPlayers: 2400,
                                  lang: 'null'
                                ));
                          });
                    }
                    else {       
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Divider(
                                color: Color(0xff4F4F4F),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ServerCard(
                                serverName: _getServerName(index),
                                data: snapshot.data[index]);
                          });
                    }
                  }),
              SizedBox(height: 30),
              Text('ОБЩИЙ ОНЛАЙН ' + _totalOnline.toString(),
                  style: kHeaderTextStyle),
              SizedBox(height: 15),
              RaisedButton(
                onPressed: () async =>
                    await Navigator.pushNamed(context, LoginPage.id),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Text('ПРОДОЛЖИТЬ'),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                color: Color(0xff3D3D3D),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          width: double.infinity,
          height: 30,
          child: Center(
              child: Text('VK.COM/DESSSY',
                  style: TextStyle(
                      color: Color(0xff343434), fontWeight: FontWeight.bold)))),
    );
  }

  Future<List<ServerData>> _getServerList() async {
    int calculatedOnline = 0;
    try {
      _network = Network(url: serverListUrl);
      await _network.parseInfo();
      final data = await _network.getJsonData();
      final serversData = [
        data['insquad.gta5rp.com:22005'],
        data['strawberry.gta5rp.com:22005'],
        data['vinewood.gta5rp.com:22005'],
        data['blackberry.gta5rp.com:22005'],
        data['downtown.gta5rp.com:22005'],
        data['sunrise.gta5rp.com:22005']
      ];
      List<ServerData> serverInfo = [];
      //asign data to class
      serversData.forEach((element) => {
            serverInfo.add(new ServerData(
                players: element['players'],
                maxPlayers: element['maxplayers'],
                lang: element['lang'])),
            calculatedOnline += element['players']
          });
      return _serverInfo;
    } catch (e) {
      print('ERROR:: ' + e.toString());
      return null;
    }
  }

  Future<void> _getData() async {
    int calculatedOnline = 0;
    try {
      _network = Network(url: serverListUrl);
      await _network.parseInfo();
      final data = await _network.getJsonData();
      final serversData = [
        data['insquad.gta5rp.com:22005'],
        data['strawberry.gta5rp.com:22005'],
        data['vinewood.gta5rp.com:22005'],
        data['blackberry.gta5rp.com:22005'],
        data['downtown.gta5rp.com:22005'],
        data['sunrise.gta5rp.com:22005']
      ];
      List<ServerData> serverInfo = [];
      //asign data to class
      serversData.forEach((element) => {
            serverInfo.add(new ServerData(
                players: element['players'],
                maxPlayers: element['maxplayers'],
                lang: element['lang'])),
            calculatedOnline += element['players']
          });
      setState(() {
        _serverInfo = serverInfo;
        _totalOnline = calculatedOnline;
      });
    } catch (e) {
      print('ERROR:: ' + e.toString());
    }
  }

  _getServerName(index) {
    switch (index) {
      case 0:
        return 'INSQUAD';
      case 1:
        return 'STRAWBERRY';
      case 2:
        return 'VINEWOOD';
      case 3:
        return 'BLACKBERRY';
      case 4:
        return 'DOWNTOWN';
      case 5:
        return 'SUNRISE';
    }
  }
}
