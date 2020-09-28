import 'package:aqar_bazar/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/screens/landing.dart';
import 'package:flutter/services.dart';

import 'screens/landing.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xff015CA8),
      accentColor: Color(0xffECF9F8),
    ),
    routes: {
      '/': (context) => OnBoardingPage(),
      '/home': (context) => Home(),
    },
  ));
}
