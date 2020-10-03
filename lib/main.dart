import 'package:aqar_bazar/screens/Landing_and_Home/Home.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/new_home.dart';
import 'package:aqar_bazar/screens/Property%20types/house.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/landing.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xff015ca8),
      accentColor: Color(0xffECF9F8),
      primaryColorLight: Color(0xccECF9F8),
    ),
    routes: {
      '/': (context) => OnBoardingPage(),
      '/home': (context) => NewHome(),
    },
  ));
}
