import 'package:flutter/material.dart';

class CharacterInfoCard extends StatelessWidget {
  CharacterInfoCard(
      {this.characerName, this.level, this.inGameHourse, this.vipStatus, this.onTap});
  final String characerName;
  final int level;
  final String inGameHourse;
  final int vipStatus;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(child: Container()),
      ),
    );
  }
}
