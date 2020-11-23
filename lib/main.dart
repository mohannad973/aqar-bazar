import 'package:aqar_bazar/models/like_comment_response.dart';
import 'package:aqar_bazar/providers/add_comment_provider.dart';
import 'package:aqar_bazar/providers/all_properties_provider.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/landing.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Utils/session_manager.dart';
import 'localization/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff015ca8),
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(MyHomePage());



}

class MyHomePage extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyHomePageState state = context.findAncestorStateOfType<_MyHomePageState>();
    state.changeLanguage(newLocale);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Locale _locale;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  String token='';
  String locale;

  _getToken() async{
    SessionManager sessionManager = SessionManager();
    token = await sessionManager.getAuthToken();
    locale = await sessionManager.getLocale();

    switch (locale){
      case '1':
        setState(() {
          _locale = Locale('en','US');
        });
        break;
      case '2':
        setState(() {
          _locale = Locale('ar','AE');
        });
        break;
      default :
        setState(() {
          _locale = Locale('en','US');
        });
        break;

    }
  print('main token' + (token==null).toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ChangeNotifierProvider<AllPropertiesProvider>(
            create: (_) => AllPropertiesProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff015ca8),
          accentColor: Color(0xffECF9F8),
          primaryColorLight: Color(0xccECF9F8),
        ),
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'AE')],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        localizationsDelegates: [
          Applocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        routes: {
          '/': (context) => (token == null || token =='') ? OnBoardingPage() : NewHome() ,
          '/home': (context) => NewHome(),
        },
        locale: _locale,
      ),
    );
  }
}


