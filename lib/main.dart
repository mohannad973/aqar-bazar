import 'package:aqar_bazar/providers/login_provider.dart';
import 'package:aqar_bazar/providers/preferences_provider.dart';
import 'package:aqar_bazar/providers/property_parameters_provider.dart';
import 'package:aqar_bazar/providers/search_params_provider.dart';
import 'package:aqar_bazar/providers/search_result_provider.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/new_home.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/landing.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff015ca8),
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SearchParamsProvider>(
          create: (_) => SearchParamsProvider()),
      ChangeNotifierProvider<LogInProvider>(create: (_) => LogInProvider()),
      ChangeNotifierProvider<PreferencesProvider>(
        create: (_) => PreferencesProvider(),
      ),
      ChangeNotifierProvider<PropertyParametersProvider>(
          create: (_) => PropertyParametersProvider()),
      ChangeNotifierProvider<SearchResultProvider>(
          create: (_) => SearchResultProvider()),
    ],
    child: MaterialApp(
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
    ),
  ));
}
