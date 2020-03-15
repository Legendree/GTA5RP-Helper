import 'package:flutter/material.dart';
import 'package:gta5rp_app/constants.dart';
import 'package:gta5rp_app/server_data.dart';

class ServerCard extends StatelessWidget {
  ServerCard({this.serverName, this.data});
  final ServerData data;
  final String serverName;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 90,
          child: Text(serverName, style: kTextStyle)),
        Container(
          width: 50,
          child: Text(data.players.toString(), style: kTextStyle)),
        Container(
          width: 50,
          child: Text(data.maxPlayers.toString(), style: kTextStyle)),
        Container(
          width: 50,
          child: Text(data.lang.toUpperCase(), style: kTextStyle))
      ],
    );
  }
}