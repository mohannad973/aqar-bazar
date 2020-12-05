import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/models/add_comment_model.dart';
import 'package:aqar_bazar/models/book_success_response.dart';
import 'package:aqar_bazar/models/cancel_request_response.dart';
import 'package:aqar_bazar/models/comments_response.dart';
import 'package:aqar_bazar/models/contact_us_response.dart';
import 'package:aqar_bazar/models/like_comment_response.dart';
import 'package:aqar_bazar/models/single_property_response.dart';
import 'package:aqar_bazar/models/succes_string_response.dart';
import 'package:aqar_bazar/models/user_requests_response.dart';
import 'package:aqar_bazar/screens/Auth/models/log_in_response.dart';
import 'package:aqar_bazar/screens/Auth/models/register_success_response.dart';
import 'package:aqar_bazar/screens/filter/search_result_model.dart';
import 'package:aqar_bazar/screens/profile/models/user_profile_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://aqarbazar.com/api";

SessionManager sessionManager = SessionManager();

class Api {
  Future getSearchParameters(String lang) {
    var url = baseUrl + "/v1/searchParameters";
    return http.get(url, headers: {
      'langLabel': lang,
    });
  }

  Future search(
      { String furnished,
      String type,
      String city,
      String rooms,
      String bathrooms,
      String category,
      String price,
      String capacity,
      String token,
      String cookie,
      String lang,
      String currency}) {
    print("from api class 989786" + furnished);
    var url = baseUrl + "/v1/search";
    print("uuuuuuuurrrrrrrl" + url);
    return http.post(url, headers: {
      'Authorization': 'Bearer $token',
      'langLabel': lang,
      'cookie': cookie,
      'currency': currency
    });
  }

  Future filter(
      {String furnished,
      String type,
      String rooms,
      String price,
      String capacity,
      int page,
      String token,
      String cookie,
      String lang,
      String currency}) {
    print("from api class 989786" + furnished);
    var url = baseUrl + "/v1/search?page=$page";
    print("uuuuuuuurrrrrrrl" + url);
    return http.post(url, body: {
      'furnished': furnished,
      'type': type,
      'price_range': price,
      'capacity': capacity,
      'rooms': rooms
    }, headers: {
      'Authorization': 'Bearer $token',
      'langLabel': lang,
      'cookie': cookie,
      'currency': currency
    });
  }

  Future getPreferences(String lang) {
    var url = baseUrl + "/v1/getPreferences";
    return http.get(url, headers: {'langLabel': lang});
  }

  Future getPropertyParameters(int langId) {
    print('test3');
    var url = baseUrl + "/v1/propertyParameters";
    return http.get(url, headers: {'frontLang': langId.toString()});
  }

  Future login(String email, String password) async {
    try {
      print('777777');
      //print('login cookie : '+coo);
      final String apiUrl = baseUrl + '/v1/login';
      final response =
          await http.post(apiUrl, body: {"email": email, "password": password});

      print('statusCode : ' + response.statusCode.toString());

      if (response.statusCode == 401) {
        return response.statusCode;
      }

      print('email :' + email + 't');
      print('pass :' + password + 'p');
      int index = response.headers['set-cookie'].indexOf(';');
      String cookie = response.headers['set-cookie'].substring(0, index);

      sessionManager.setSessionToken(cookie);
      print('login cookie :' + cookie);

      if (response.statusCode == 200) {
        final String responseString = response.body;

        return signInResponseFromJson(responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      print('9999999' + e.toString());
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

  Future getPropertyInfo(String url, String token, String lang, String cookie,
      String currency) async {
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'langLabel': lang,
        'cookie': cookie,
        'currency': currency
      });

      if (response.statusCode == 200) {
        return singlePropertyResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {}
  }

  Future requestProperty(String token, String id, String cookie) async {
    try {
      String url = baseUrl + '/properties/${id}/requestProperty';
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
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

  Future cancelRequest(String token, String id, String cookie) async {
    try {
      String url = baseUrl + '/v1/request/$id/cancel';
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('cancel request ' + response.body);

      if (response.statusCode == 200) {
        return cancelRequestResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future getComments(
      String propertId, int pageNumber, String token, String cookie) async {
    print('tstToken ' + token);
    print('tstCookie ' + cookie);
    try {
      String url =
          baseUrl + '/properties/$propertId/comments?page=${pageNumber}';

      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.trim()}',
        // 'Cookie': cookie.trim(),
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

  Future likeComment(String commentId, String token, String cookie) async {
    try {
      String url = baseUrl + '/properties/$commentId/likeComment';

      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie
      });

      if (response.statusCode == 200) {
        return likeComentResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future addComment(
      String token, String id, String cookie, String comment) async {
    try {
      String url = baseUrl + '/properties/$id/makeComment';

      print('testadd1 ' + url);
      final response = await http.post(url, body: {
        'comment': comment
      }, headers: {
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('testadd2 ' + response.body);

      print('testadd1 ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return addCommentResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future getAllRequests(String token, String cookie, int page, String lang,
      String currency) async {
    try {
      print('////////// ' + lang);
      String url = baseUrl + '/v1/requests?page=$page';

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        // 'Cookie': cookie,
        'Authorization': 'Bearer $token',
        'langLabel': lang,
        'currency': currency
      });

      print('all requests1 ' + response.body);

      print('all requests2  ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return userRequestsResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future contactHost(
      String token, String cookie, String propertyId, String message) async {
    try {
      String url = baseUrl + '/properties/$propertyId/contactHost';

      final response = await http.post(url, body: {
        'message': message
      }, headers: {
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('contact host ' + response.body);
      print('contact host 2' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return successStringResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future getAllProperties(
      String cookie, int page, String lang, String currency) async {
    print('lang all ' + lang);
    try {
      String url = baseUrl + '/v1/properties?page=$page';

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Cookie': cookie,
        'langLabel': lang,
        'currency': currency
      });

      print('all properties1 ' + response.body);

      print('all properties2  ' + response.statusCode.toString());

      if (response.statusCode == 200) {
        return searchResultModeFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error ' + e.toString());
    }
  }

  Future contactUs(
      String email, String name, String phone, String message) async {
    try {
      final String apiUrl = baseUrl + '/v1/submitContact';
      final response = await http.post(apiUrl, body: {
        "email": email,
        "name": name,
        "phone": phone,
        "message": message,
      });

      if (response.statusCode == 200) {
        final String responseString = response.body;

        return contactUsResponseFromJson(responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future pay(String propertyId, String amount) async {
    try {
      final String apiUrl =
          baseUrl + '/v1/book/paypal?property_id=$propertyId&amount=$amount';
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print("response webview : " + responseString);

        return (responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getNotifications(String token, String cookie) async {
    try {
      final String apiUrl = baseUrl + '/v1/notifications';
      final response = await http.get(apiUrl, headers: {
        'Accept': 'application/json',
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });

      print('nots ' + response.toString());
      if (response.statusCode == 200) {
        final String responseString = response.body;

        print("response notif : " + responseString);

        return (responseString);
      } else {
        print(response.statusCode);

        return null;
      }
    } catch (e) {
      print('errr 80' + e.toString());
      return null;
    }
  }

  Future searchByPropertyType(
      {String propertyType,
      int page,
      String token,
      String cookie,
      String lang,
      String currency}) {
    var url = baseUrl + "/v1/search?page=$page";
    return http.post(url, body: {
      "category": propertyType
    }, headers: {
      'Authorization': 'Bearer $token',
      'langLabel': lang,
      'cookie': cookie,
      'currency': currency
    });
  }

  Future getFavourites(
      {int page, String token, String cookie, String lang, String currency}) {
    try {
      var url = baseUrl + "/v1/favourites?page=$page";
      var response = http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'langLabel': lang,
        'currency': currency
        // 'cookie': cookie
      });
      print('fav2 ' + response.toString());
      return response;
    } catch (e) {
      print('fav3 ' + e.toString());
      return null;
    }
  }

  Future addToFav({
    String propertyId,
    String token,
  }) {
    try {
      var url = baseUrl + "/properties/$propertyId/favorite";
      var response = http.post(url, headers: {
        'Authorization': 'Bearer $token',
      });

      return response;
    } catch (e) {
      return null;
    }
  }



  Future bookProperty(String token, String id, String cookie,String from , String to , String amount , String sellType ) async {
    try {
      String url = baseUrl + '/v1/bookProperty';
      final response = await http.post(url,body:{
        "property_id":id,
        "selling_type":sellType,
        "amount":amount,
        "from":from,
        "to":to

      }, headers: {
        'Cookie': cookie,
        'Authorization': 'Bearer $token',
      });
      print('book1 '+ response.statusCode.toString());
      if (response.statusCode == 200) {

        print('book5 '+response.toString());
        print('book6 '+response.body.toString());
        print('book7 '+bookSuccessResponseFromJson(response.body).toString());
        return bookSuccessResponseFromJson(response.body);
      } else {
        print('book2 '+ id+" "+ from+ " "+ to + " "+amount+ " "+ sellType);
        return null;
      }
    } catch (e) {
      print('book3 '+ e.toString());
      print('error ' + e.toString());
    }
  }

}
