import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:aqar_bazar/screens/settings/preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://aqarbazar.com/aqarbazar/api";

SessionManager sessionManager = SessionManager();

class Api {
  Future getSearchParameters() {
    var url = baseUrl + "/v1/searchParameters";
    return http.get(url);
  }

  Future search(
      {String furnished,
      String type,
      String city,
      String rooms,
      String bathrooms,
      String category,
      String price,
      String capacity}) {
    print("from api class 989786" + furnished);
    var url = baseUrl + "/v1/search";
    print("uuuuuuuurrrrrrrl" + url);
    return http.post(url);
  }

  Future getPreferences() {
    var url = baseUrl + "/v1/getPreferences";
    return http.get(url);
  }

  Future getPropertyParameters() {
    print('test3');
    var url = baseUrl + "/v1/propertyParameters";
    return http.get(url);
  }

  Future login(String email, String password) async {
    try {
      final String apiUrl = baseUrl + '/v1/login';
      final response =
          await http.post(apiUrl, body: {"email": email, "password": password});

      int index = response.headers['set-cookie'].indexOf(';');
      String cookie = response.headers['set-cookie'].substring(0, index);
      print('cookies3 :' + cookie);

      sessionManager.setSessionToken(cookie);

      if (response.statusCode == 200) {
        final String responseString = response.body;
        return signInResponseFromJson(responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future register(String email, String password, String firstName,
      String lastName, String passwordConfirm) async {
    try {
      final String apiUrl = baseUrl + '/v1/register';
      final response = await http.post(apiUrl, body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirm
      });

      if (response.statusCode == 201) {
        final String responseString = response.body;

        return registerSuccessResponseFromJson(responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getUserProfile(String token) async {
    try {
      String url = baseUrl + '/v1/user';

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return userProfileResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future getPropertyInfo(String url, String token) async {
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',

      });

      if (response.statusCode == 200) {

        return singlePropertyResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future requestProperty(String token, String id,String cookie) async {
    try {

      String url = baseUrl + '/properties/${id}/requestProperty';
      final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cookie': cookie,

          });




      print('55555555555  ' + response.body);
      if (response.statusCode == 200) {
        return successStringResponseFromJson(response.body);
      } else {
        print('444444444  ' + response.body);
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }



  Future getComments(String propertId, int pageNumber, String token,String cookie) async {
    try {
      String url =
          baseUrl + '/properties/$propertId/comments?page=${pageNumber}';

      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Cookie': cookie,
      });


      print('comment body ' + response.body.toString());

      if (response.statusCode == 200) {
        return commentsResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }
}
