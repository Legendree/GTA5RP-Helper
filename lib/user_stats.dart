import 'package:flutter/material.dart';
import 'package:gta5rp_app/character_info.dart';
import 'package:gta5rp_app/character_info_card.dart';
import 'package:gta5rp_app/header_card.dart';
import 'package:html/dom.dart' as dom;

class UserStatsPage extends StatefulWidget {
  UserStatsPage({this.document});
  final dom.Document document;
  @override
  _UserStatsPageState createState() => _UserStatsPageState();
}

class _UserStatsPageState extends State<UserStatsPage> {

  List<String> headerData;
  List<CharacterInfoCard> charactersData;

  @override
  void initState() {
    super.initState();
    headerData = new List<String>();
    charactersData = new List<CharacterInfoCard>();
  }

  @override
  void dispose() {
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
                future: _getHeaderData(),
                builder: (context, snapshot) {
                  var name = '';
                  var dp = '';
                  if (snapshot.hasError) {
                    name = 'Пробелма';
                    dp = 'код: 1338';
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    name = headerData[1];
                    dp = headerData[0];
                  } else {
                    name = 'Загрузка...';
                    dp = 'Загрузка...';
                  }
                  return HeaderCard(dp: name, name: dp);
                }),
                FutureBuilder(
                future: _parseUserData(),
                builder: (context, snapshot) {
                  Widget _widgetToDisplay;
                  if (snapshot.hasError) {
                    _widgetToDisplay = CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    _widgetToDisplay = charactersData[0];
                  } else {
                    _widgetToDisplay = CircularProgressIndicator();
                  }
                  return _widgetToDisplay;
                }),
          ],
        )),
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

  Future<void> _parseUserData() async {
    //extracting data from containers
    final characters = widget.document.getElementsByClassName(
        'playerInfo__card gradient__box ucp__playerInfo ucp__playerInfo--gradient');
    var characterInfo = [];
    characters.forEach((character) {
      character.text.replaceAll(' ', '').split('\n').forEach((f) {
        if (f.isNotEmpty) characterInfo.add(f);
      });
    });

    //extracting player status
    final status = widget.document.getElementsByClassName('ml-4 ucp__status ucp__status--offline');


    //exracting character experience
    final exp = widget.document.getElementsByClassName('ucp__exp--p');
    var myExp = '';
    exp[0].text.split('\n').forEach((f) {
      myExp += f.trim() + ' ';
    });

    //extracting character cash
    final cash =widget.document.getElementsByClassName('ucp__balance mb-0 mt-4');
    var myCash = cash[0].text.split('\n')[2].trim();

    //extracting character bank cash
    final creditCash = widget.document.getElementsByClassName('ucp__balance--card mb-0 mt-4');
    var myCreditCash = creditCash[0].text.split('\n')[2].trim();

    //extracting character gender 
    final genderAge = widget.document.getElementsByClassName('d-flex flex-row flex-wrap justify-content-between w-100 pb-4');
    var arr = genderAge[0].text.split('\n');
    var gender = arr[3].trim();
    var age = arr[7].trim();

    final vehicles = widget.document.getElementsByClassName('linearSlider__slides');
      
    charactersData.add(new CharacterInfoCard(
      characterInfo: CharacterInfo(
        characterName: characterInfo[1],
        level: characterInfo[0],
        inGameHours: characterInfo[3][0],
        vipStatus: characterInfo[5],
        exp: myExp.substring(1),
        cash: myCash,
        money: myCreditCash,
        sex: gender,
        age: age,
        status: status[0].text.trim(),
      )));
  }

  _getHeaderData() async {
    final name = widget.document.getElementsByClassName('accountInfo__name');
    final dp = widget.document.getElementsByClassName('accountInfo__score');
    headerData.add(name[0].text.trim());
    headerData.add(dp[0].text.trim().substring(5).trim());
  }
}

/*
  _getServerData(Server server) async {
    final parser = PageParser(url: _getServerUrl(server));
    if (!(await parser.parseData(client, accessCookie))) return;
    //final title = parser.document().getElementsByClassName('accountInfo__name')
    //  .forEach((f) => print(f.text));
    final accountInfoName =
        parser.document().getElementsByClassName('accountInfo__name');
    print(accountInfoName[0].text.trim());
  }
*/
