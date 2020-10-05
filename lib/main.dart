import 'package:aqar_bazar/screens/Landing_and_Home/Home.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/new_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  final _appKey = GlobalKey();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff015ca8),
    systemNavigationBarColor: Colors.white,
  ));
  runApp(MaterialApp(
    key: _appKey,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xff015ca8),
      accentColor: Color(0xffECF9F8),
      primaryColorLight: Color(0xccECF9F8),
    ),
    routes: {
      '/': (context) => NewHome(),
      '/home': (context) => NewHome(),
    },
  ));
}
