
import 'package:aqar_bazar/Network/Api.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/models/property_parameters_model.dart';
import 'package:aqar_bazar/screens/settings/preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SinglePropertyProvider with ChangeNotifier{

  bool loading = false;

  Api api = new Api();
  SessionManager sessionManager = SessionManager();

  SinglePropertyResponse singlePropertyResponse = SinglePropertyResponse();
  SingleProperty singleProperty ;
  List<String> attachments = [];

  Future<SingleProperty> getPropertyInfo(String url) async {
    setLoading(true);
    try {
      attachments.clear();
      String token = await sessionManager.getAuthToken();
      String lang = await sessionManager.getLang();
      String cookie = await sessionManager.getSessionToken();
      String currency = await sessionManager.getCurrency()==null?"USD": await sessionManager.getCurrency();
      // print('rr3 '+token);
       print('rr4 '+(lang==null).toString());
       print('rr5 '+(cookie==null).toString());

      SinglePropertyResponse response = await api.getPropertyInfo(url,token,lang,cookie,currency);

      print('rr6 '+response.toString());

      if(response != null){
        //singlePropertyResponse = singlePropertyResponseFromJson(response.body);
        singleProperty = response.data;
        attachments = response.data.attachments;

        print('rr7 '+singleProperty.isBooked.toString());



        setLoading(false);
        return singleProperty;
      }

      if (singleProperty == null) {
        print('rr8 '+singleProperty.toString());
        setLoading(false);

        return singleProperty;
      }
      print('rr9 '+singleProperty.toString());
      setLoading(false);
      return singleProperty;
    } catch (e) {
      print('rr10 '+e.toString());
      setLoading(false);
      return null;
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }



}