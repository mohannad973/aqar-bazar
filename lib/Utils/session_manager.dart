
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';


class SessionManager {
  final String auth_token = "auth_token";


//set data into shared preferences like this
  Future<void> setAuthToken(String auth_token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, auth_token);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token;
    auth_token = pref.getString(this.auth_token) ?? null;
    return auth_token;
  }


  final String sessionToken = "SESSION_TOKEN";

  Future<void> setSessionToken(String session) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.sessionToken, session);
  }

//get value from shared preferences
  Future<String> getSessionToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String session;
    session = pref.getString(this.sessionToken) ?? null;
    return session;
  }


  Future<void> clearSessionManager() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }



  final String APP_LOCALE = "app_locale";


//set data into shared preferences like this
  Future<void> setLocale(String locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString(this.APP_LOCALE, locale);


  }

//get value from shared preferences
  Future<String> getLocale() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String locale;
    locale = pref.getString(this.APP_LOCALE) ?? null;
    return locale;
  }


  final String LANG = 'LANG';
  Future<void> setLang(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.LANG, lang);

  }

//get lang from shared preferences
  Future<String> getLang() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String lang;
    lang = pref.getString(this.LANG) ?? 'en';
    return lang;
  }


  final String CURRENCY = 'CURRENCY';
  Future<void> setCurrency(String currency) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.CURRENCY, currency);
  }

  Future<String> getCurrency() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String currency;
    currency = pref.getString(this.CURRENCY) ?? 'USD';
    return currency;
  }

}