import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CharacterInfoCard extends StatelessWidget {
  CharacterInfoCard(
      {this.characerName,
      this.level,
      this.inGameHourse,
      this.vipStatus,
      this.onTap});
  final String characerName;
  final String level;
  final String inGameHourse;
  final String vipStatus;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              Text(characerName.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20)),
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
                      child: Text(level, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
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
                  Text(inGameHourse + ' часов',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              )
            ],
      ),
    ),
          ),
        ));
  }
}
