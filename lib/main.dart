import 'package:aqar_bazar/models/like_comment_response.dart';
import 'package:aqar_bazar/providers/add_comment_provider.dart';
import 'package:aqar_bazar/providers/cancel_request_provider.dart';
import 'package:aqar_bazar/providers/comments_provider.dart';
import 'package:aqar_bazar/providers/contact_host_provider.dart';
import 'package:aqar_bazar/providers/like_comment_provider.dart';
import 'package:aqar_bazar/providers/login_provider.dart';
import 'package:aqar_bazar/providers/preferences_provider.dart';
import 'package:aqar_bazar/providers/property_parameters_provider.dart';
import 'package:aqar_bazar/providers/register_provider.dart';
import 'package:aqar_bazar/providers/request_property_provider.dart';
import 'package:aqar_bazar/providers/search_params_provider.dart';
import 'package:aqar_bazar/providers/search_result_provider.dart';
import 'package:aqar_bazar/providers/single_property_provider.dart';
import 'package:aqar_bazar/providers/user_profile_provider.dart';
import 'package:aqar_bazar/providers/user_requests_provider.dart';
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
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider()),
      ChangeNotifierProvider<USerProfileProvider>(
          create: (_) => USerProfileProvider()),
      ChangeNotifierProvider<SinglePropertyProvider>(
          create: (_) => SinglePropertyProvider()),
      ChangeNotifierProvider<RequestPropertyProvider>(
          create: (_) => RequestPropertyProvider()),
      ChangeNotifierProvider<CommentsProvider>(
          create: (_) => CommentsProvider()),
      ChangeNotifierProvider<LikeCommentProvider>(
          create: (_) => LikeCommentProvider()),
      ChangeNotifierProvider<CancelRequestProvider>(
          create: (_) => CancelRequestProvider()),
      ChangeNotifierProvider<AddComentProvider>(
          create: (_) => AddComentProvider()),
      ChangeNotifierProvider<UserRequestProvider>(
          create: (_) => UserRequestProvider()),
      ChangeNotifierProvider<ContactHostProvider>(
          create: (_) => ContactHostProvider()),
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
