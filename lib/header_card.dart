import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderCard extends StatelessWidget {
  HeaderCard({this.name, this.dp});
  final String name;
  final String dp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff272729),
          border: Border.all(color: Colors.orange),
        ),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.person, color: Colors.white),
                SizedBox(width: 5),
                Text(name, style: TextStyle(color: Colors.white))
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(FontAwesomeIcons.moneyBill, size: 20, color: Colors.white),
                SizedBox(width: 12),
                Text(dp, style: TextStyle(color: Colors.white))
              ],
            )
          ],
        )
      ),
    );
  }
}