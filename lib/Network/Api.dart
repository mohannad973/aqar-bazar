import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/settings/preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://aqarbazar.com/aqarbazar/api";
class Api{

  Future getSearchParameters() {
    var url = baseUrl + "/v1/searchParameters";
    return http.get(url);
  }

  Future search({String furnished , String type , String city , String rooms , String bathrooms , String category , String price , String capacity}){

    print("from api class 989786"+ furnished);
      var url = baseUrl +"/v1/search";
      print("uuuuuuuurrrrrrrl"+url);
      return http.get(url);
  }

  Future getPreferences(){
    var url = baseUrl +"/v1/getPreferences";
    return   http.get(url);
  }



  Future getPropertyParameters(){
    var url = baseUrl +"/v1/propertyParameters";
    return   http.get(url);
  }


  Future login(String email, String password) async {
    try {
      final String apiUrl = baseUrl+'/v1/login';
      final response =
      await http.post(apiUrl, body: {"email": email, "password": password});

      if (response.statusCode == 200) {
        final String responseString = response.body;

        return signInResponseFromJson(responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    }catch(e){

      return null ;
    }
  }


}