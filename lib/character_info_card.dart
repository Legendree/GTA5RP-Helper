import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gta5rp_app/character_info.dart';
import 'package:gta5rp_app/character_page.dart';

class CharacterInfoCard extends StatelessWidget {
  CharacterInfoCard({this.characterInfo});
  final CharacterInfo characterInfo;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
                  child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff272729),
              border: Border.all(color: Color(0xff2557AF)),
                ),
      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(characterInfo.characterName.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20)),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('images/ucp_lvl.png')
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(characterInfo.level, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      )
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.clock, color: Colors.white, size: 16),
                    SizedBox(width: 5),
                    Text(characterInfo.inGameHours + ' часов',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
              ],
      ),
    ),
            ),
          ),
          onTap: () async {
             await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CharacterPage(characterInfo: characterInfo)));
          },
        ));
  }
}
