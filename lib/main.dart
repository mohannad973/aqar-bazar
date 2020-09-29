import 'package:aqar_bazar/screens/Landing_and_Home/Home.dart';
import 'package:aqar_bazar/screens/Property%20types/house.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/landing.dart';
import 'package:flutter/services.dart';

import 'screens/landing.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xff015CA8),
      accentColor: Color(0xffECF9F8),
      primaryColorLight: Color(0xccECF9F8),
    ),
    routes: {
      '/': (context) => Home(),
      '/home': (context) => Home(),
    },
  ));
}
