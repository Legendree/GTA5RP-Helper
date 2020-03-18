import 'package:flutter/material.dart';
import 'package:gta5rp_app/login_page.dart';
import 'package:gta5rp_app/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GTA5RP',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff181818),
        textTheme: TextTheme()
      ),
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        LoginPage.id: (context) => LoginPage(),    
      },
    );
  }
}