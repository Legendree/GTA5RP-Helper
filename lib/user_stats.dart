import 'package:flutter/material.dart';
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
  List<String> charactersData;

  @override
  void initState() {
    super.initState();
    headerData = new List<String>();
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
          ],
        )),
      ),
    );
  }

  _parseUserData() async {
    final characters = widget.document.getElementsByClassName(
        'playerInfo__card gradient__box ucp__playerInfo ucp__playerInfo--gradient');

    characters.forEach((character) {
      character.text.replaceAll(' ', '').split('\n').forEach((f) {
        if (f.isNotEmpty) charactersData.add(f);
      });
    });


/*
    characterCards.add(new CharacterInfoCard(
      characerName: characterInfo[1],
      level: characterInfo[0],
      inGameHourse: characterInfo[3][0],
      vipStatus: characterInfo[5],
    ));
  
  */
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
