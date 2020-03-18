import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gta5rp_app/character_info.dart';

class CharacterPage extends StatefulWidget {
  CharacterPage({this.characterInfo});
  final CharacterInfo characterInfo;
  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  @override
  void initState() {
    super.initState();
    print(widget.characterInfo.characterName);
    print(widget.characterInfo.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff181818),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.characterInfo.characterName),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(widget.characterInfo.status,
                    style: TextStyle(
                        fontSize: 16,
                        color: widget.characterInfo.status == 'Оффлайн'
                            ? Colors.red
                            : Colors.green)),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xff272729),
                    border: Border.all(color: Color(0xff2557AF)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Уровень ' + widget.characterInfo.level,
                                style: TextStyle(color: Colors.white)),
                            Text(widget.characterInfo.exp.trim(),
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.white.withOpacity(0.05)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('VIP статус:',
                                style: TextStyle(color: Colors.white)),
                            Text(widget.characterInfo.vipStatus,
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.white.withOpacity(0.05)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.account_balance_wallet,
                                    size: 22, color: Colors.white),
                                SizedBox(width: 6),
                                Text(widget.characterInfo.cash,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.credit_card,
                                    size: 22, color: Colors.white),
                                SizedBox(width: 6),
                                Text(widget.characterInfo.money,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.white.withOpacity(0.05)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Пол:', style: TextStyle(color: Colors.white)),
                            Text(widget.characterInfo.sex,
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.white.withOpacity(0.05)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Возраст:',
                                style: TextStyle(color: Colors.white)),
                            Text(widget.characterInfo.age,
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 15),
                  Container(
                  decoration: BoxDecoration(
                    color: Color(0xff272729),
                    border: Border.all(color: Color(0xff2557AF)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.building, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Транспорт',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                        Container(
                          height: 100,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    color: Colors.white.withOpacity(0.05),
                                    width: 120,
                                    child: Center(child: Text('У вас пока нету машины', style: TextStyle(color: Colors.white.withOpacity(0.2)), textAlign: TextAlign.center))
                                  ),
                                  SizedBox(width: 30),
                                  Container(
                                    color: Colors.white.withOpacity(0.05),
                                    width: 120,
                                    child: Center(child: Text('У вас пока нету машины', style: TextStyle(color: Colors.white.withOpacity(0.2)), textAlign: TextAlign.center))
                                  ),
                                  SizedBox(width: 30),
                                  Container(
                                    color: Colors.white.withOpacity(0.05),
                                    width: 120,
                                    child: Center(child: Text('У вас пока нету машины', style: TextStyle(color: Colors.white.withOpacity(0.2)), textAlign: TextAlign.center))
                                  ),
                                  SizedBox(width: 30),
                                  Container(
                                    color: Colors.white.withOpacity(0.05),
                                    width: 120,
                                    child: Center(child: Text('У вас пока нету машины', style: TextStyle(color: Colors.white.withOpacity(0.2)), textAlign: TextAlign.center))
                                  ),
                                ],
                              ),
                            )
                          )
                          )
                      ],
                    ),
                  )),
              SizedBox(height: 15),
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xff272729),
                    border: Border.all(color: Color(0xff2557AF)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.home, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Дом',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                        Container(
                          height: 100,
                          child: Center(
                            child: Text('У вас пока нет дома', style: TextStyle(color: Colors.white.withOpacity(0.3))),
                          )
                          )
                      ],
                    ),
                  )),
                  SizedBox(height: 15),
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xff272729),
                    border: Border.all(color: Color(0xff2557AF)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.building, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Бизнес',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                        Container(
                          height: 100,
                          child: Center(
                            child: Text('У вас пока нет бизнеса', style: TextStyle(color: Colors.white.withOpacity(0.3))),
                          )
                          )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
